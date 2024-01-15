import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/key_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../authentication_screen/model/user_model.dart';
import '../../firebase_services/services/firebase_services.dart';
import '../../firebase_services/services/notification_services.dart';
import '../../routing.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  var imageUrl;

  // File? profileImage;
  var profileImage;
  var updatedProfileImage;
  var nameError = "";
  var imageError = "";
  String url = '';
  bool shimmerEffectLogin = false;
  bool shimmerEffectOtp = false;
  bool shimmerEffectProfileSetup = false;

  void validationProfileImage() {
    if (updatedProfileImage == null&&url.isEmpty) {
      imageError = "Please select the image";
    } else {
      imageError = "";
      validationProfile();
    }
    update();
  }

  validationProfile() async {
    if (nameController.text
        .trim()
        .isEmpty) {
      nameError = "Please enter your name";
    } else {
      nameError = "";
      shimmerEffectProfileSetup = true;
      updateProfile().then((value) {
        updatedProfileImage = null;
      });
      Get.back();
      shimmerEffectProfileSetup = false;
    }
    update();
  }

  updateProfile() async {
    if(updatedProfileImage!=null){
      var result = await FirebaseStorage.instance.ref(
          DateTime.timestamp().toString()).putFile(
          File(updatedProfileImage!.path));
      imageUrl = await result.ref.getDownloadURL();
      await FireBaseConstants.fireStore.collection(KeyConstants.kUser).doc(
          FireBaseConstants.auth.currentUser!.uid).update({
        KeyConstants.kName: nameController.text,
        KeyConstants.kAboutMe: descriptionController.text,
        KeyConstants.kProfileImageURL:imageUrl
      });
    }
    else{
      await FireBaseConstants.fireStore.collection(KeyConstants.kUser).doc(
          FireBaseConstants.auth.currentUser!.uid).update({
        KeyConstants.kName: nameController.text,
        KeyConstants.kAboutMe: descriptionController.text,
      });
    }
  }

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      profileImage = imageTemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Get.back();
    update();
  }

  Future pickImageCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update();
      Get.back();
    }
  }
}