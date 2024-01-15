import 'dart:developer';
import 'dart:io';

import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/chat_screen/controller/chat_screen_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/story_model.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/key_constants.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../authentication_screen/controller/authentication_controller.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseFirestore.instance;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;
  var controller = Get.put(AuthenticationController());

  var controllerChat = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController());

  Future profileSetUP() async {
    var result = await FirebaseStorage.instance
        .ref(DateTime.timestamp().toString())
        .putFile(File(controller.updatedProfileImage!.path));

    controller.imageUrl = await result.ref.getDownloadURL();
    log("Profile uploaded");
    await storage
        .collection(KeyConstants.kUser)
        .doc(auth.currentUser!.uid)
        .set(UserModel(
                uid: auth.currentUser!.uid,
                name: controller.nameController.value.text,
                phoneNumber:
                    "+${controller.countryCode + controller.phoneNumberController.value.text}",
                profileImageUrl: controller.imageUrl,
                aboutMe: controller.descriptionController.value.text,
                country: controller.countryName,
                fcmToken: await fcm.getToken())
            .toJson())
        .onError((error, stackTrace) {
      log("not able to update data");
    });
    Get.offAllNamed(customBottomBar);
  }

  Future addingUserStory() async {
    var result = await FirebaseStorage.instance
        .ref(DateTime.timestamp().toString())
        .putFile(File(controllerChat.imageStory!.path));
    controllerChat.storyUrl = await result.ref.getDownloadURL();
    log("Story uploaded");
    UserModel userModel = UserModel();
    var collection = FireBaseConstants.fireStore.collection(KeyConstants.kUser);
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      if (data[KeyConstants.kUid] == FireBaseConstants.auth.currentUser!.uid) {
        userModel = UserModel(
            uid: data[KeyConstants.kUid],
            name: data[KeyConstants.kName],
            profileImageUrl: data[KeyConstants.kProfileImageURL]);
      }
    }

    await storage.collection(KeyConstants.kStory).doc(userModel.uid).set({
      KeyConstants.kLatest: DateTime.now().toString(),
      KeyConstants.kUid: FireBaseConstants.auth.currentUser!.uid
    });
    await storage
        .collection(KeyConstants.kStory)
        .doc(FireBaseConstants.auth.currentUser!.uid)
        .collection(KeyConstants.kUserStories)
        .doc()
        .set(StoryModel(
          uid: userModel.uid,
          storyUrl: controllerChat.storyUrl,
          name: userModel.name,
          dateTime: DateTime.now().toString(),
          profileImage: userModel.profileImageUrl,
          peopleSeenUid: [],
          caption: controllerChat.captionController.text,
        ).toJson())
        .onError((error, stackTrace) {
      log("not able to update data");
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(loginScreen);
  }
}
