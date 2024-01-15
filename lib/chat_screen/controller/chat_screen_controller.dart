import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:chatwave_flutter/chat_screen/model/all_user_model.dart';
import 'package:chatwave_flutter/chat_screen/model/story_model.dart';
import 'package:chatwave_flutter/firebase_services/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../authentication_screen/model/user_model.dart';
import '../../constants/firebase_key_constants.dart';
import '../../constants/key_constants.dart';

class ChatController extends GetxController {

  //////////chat controller changes
  final TextEditingController searchController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final TextEditingController chatController = TextEditingController();
  final TextEditingController groupChatController = TextEditingController();
  TextEditingController allUserSearchController = TextEditingController();
  TextEditingController newGroupSearchController = TextEditingController();
  TextEditingController newGroupNameController = TextEditingController();

  ScrollController scroll = ScrollController();
  bool scrollChat = true;
  String messageText = '';

  // File? imageStory;
  var imageStory;
  var storyUrl;

  int chatCount = 0;

  var fcmDocId = " ";
  var fcmRecieverId = " ";
  var fcmProfileImage = " ";
  var fcmName = " ";
  String groupMessageText = '';
  UserModel userModel = UserModel();
  StoryModel storyModel = StoryModel();




  ///-------new group screen variables
  bool isMemberSelected = false;
  int totalMembers =0;
  var groupProfileImage;
  var updatedGroupProfileImage;
  var groupNameError = "";
  var groupProfileImageUrl;
  var groupCreatedBy;



  Future<bool> listExist({required String uid}) async {
    bool exist=false;
    var collection = FireBaseConstants.fireStore
        .collection(KeyConstants.kStory)
        .doc(uid)
        .collection(KeyConstants.kUserStories);
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      if ((DateTime.now()
          .isBefore(DateTime.parse(data['dateTime']).add(Duration(days: 1))))) {
        exist=true;
      }
    }
    return exist;
  }






  Future pickImageGalleryGroup() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      groupProfileImage = imageTemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Get.back();
    update();
  }

  Future pickImageCameraGroup() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      groupProfileImage = imageTemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Get.back();
    update();
  }

  validationGroupProfile() async {
    if (newGroupNameController.text.trim().isEmpty) {
      groupNameError = "Please enter group name";
    } else {
      groupNameError = "";
      // Get.toNamed(customBottomBar);
    }
    update();
  }

  Future<UserModel> userData({required String uid}) async {
    userModel = UserModel();
    var querySnapshot = await FireBaseConstants.fireStore
        .collection(KeyConstants.kUser)
        .where(KeyConstants.kUid, isEqualTo: uid)
        .get();
    print(querySnapshot.docs.first.data()[KeyConstants.kProfileImageURL]);
    userModel = UserModel(
        name: querySnapshot.docs.first.data()[KeyConstants.kName],
        profileImageUrl:
            querySnapshot.docs.first.data()[KeyConstants.kProfileImageURL]);
    return UserModel(
      name: querySnapshot.docs.first.data()[KeyConstants.kName],
      profileImageUrl:
          querySnapshot.docs.first.data()[KeyConstants.kProfileImageURL],
      uid: querySnapshot.docs.first.data()[KeyConstants.kUid],
    );
  }

  Future<List<StoryItem>> storyData(
      {required String uid, required StoryController controllerStory}) async {
    List<StoryItem> storyList = [];
    var collection = FireBaseConstants.fireStore
        .collection(KeyConstants.kStory)
        .doc(uid)
        .collection(KeyConstants.kUserStories);
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      if ((DateTime.now()
          .isBefore(DateTime.parse(data['dateTime']).add(Duration(days: 1))))) {
        storyList.add(
          StoryItem.pageImage(
              url: data['storyUrl'].toString(),
              controller: controllerStory,
              imageFit: BoxFit.fitWidth,
              caption: data['caption'].toString(),
              duration: const Duration(seconds: 5)),
        );
      }
    }
    return storyList;
  }

  Future pickImageGallery() async {
    imageStory = null;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      imageStory = imageTemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Get.back();
    update();
  }

  Future pickImageCamera() async {
    imageStory = null;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      imageStory = imageTemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Get.back();
    update();
  }

  var contactModel = <AllUsersModel>[];
  var isSelected = false;

  NotificationServices notificationServices = NotificationServices();

  @override
  void onInit() {
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "dsfdsgf",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Lofi",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Lofi",
        isShare: true));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "asdasd",
        isShare: true));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Lofi",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Loasdfi",
        isShare: true));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Lofi",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Losaffi",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "rewr",
        isShare: true));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Lofi",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "efdggdfg",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "sdferw",
        isShare: true));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Lofi",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "dsfewf",
        isShare: true));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "Lofi",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "ewrwedsc",
        isShare: true));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "ewrcdc",
        isShare: false));
    contactModel.add(AllUsersModel(
        image: "assets/images/contact_profile_image.png",
        name: "erwerew",
        isShare: false));

    //notificationServices.forgroundMessage();
    notificationServices.firebaseInit();
    notificationServices.setupInteractMessage();
    // notificationServices.isTokenRefresh();
    super.onInit();
  }

  void refreshChat() {
    try {
      Timer(
          const Duration(microseconds: 500),
          () => scroll.animateTo(
                scroll.position.maxScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInToLinear,
              ));
    } catch (e) {
      print(e);
    }
  }
}
