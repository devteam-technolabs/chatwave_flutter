import 'dart:async';
import 'dart:io';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/firebase_services/services/firebase_services.dart';
import 'package:chatwave_flutter/firebase_services/services/notification_services.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final otp1 = TextEditingController();
  final otp2 = TextEditingController();
  final otp3 = TextEditingController();
  final otp4 = TextEditingController();
  final otp5 = TextEditingController();
  final otp6 = TextEditingController();

  String countryName = '';
  String countryCode = '';
  bool selectCountry = false;
  var selectCountryError = "";
  var phoneNumberError = "";
  var nameError = "";
  var imageError = "";
  var otpError = "";
  bool otpValidColor = false;
  var imageUrl;
  // File? profileImage;
  var profileImage;
  var updatedProfileImage;

  String? receivedID;

  int? forceResendingTokenNew;

  bool shimmerEffectLogin = false;
  bool shimmerEffectOtp = false;
  bool shimmerEffectProfileSetup = false;


  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  late Timer timer;
  var start = 49;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          update();
        } else {
          start--;
          update();
        }
      },
    );
  }

  void validationProfileImage() {
    if (updatedProfileImage == null) {
      imageError = "Please select the image";
    } else {
      imageError = "";
      validationProfile();
    }
    update();
  }

  validationProfile() async {
    if (nameController.text.trim().isEmpty) {
      nameError = "Please enter your name";
    } else {
      nameError = "";
      shimmerEffectProfileSetup = true;
       FirebaseServices().profileSetUP().then((value) {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     borderRadius: 15,
        //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        //     margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 20),
        //     message: 'User profile setup Successfully',
        //     icon: const Image(
        //       image: AssetImage(
        //         Assets.imagesLoginsnackbar,
        //       ),
        //       height: 25,
        //       width: 20,
        //       color: ColorConstants.cFFFFFF,
        //       fit: BoxFit.fill,
        //     ),
        //     duration: const Duration(seconds: 3),
        //     backgroundColor: ColorConstants.c1F61E8,
        //   ),
        // );
         updatedProfileImage = null;
      });
      Get.toNamed(customBottomBar);
      shimmerEffectProfileSetup = false;
    }
    update();
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

  validationPhoneNumber() async {
    if (countryName.isEmpty && countryCode.isEmpty) {
      selectCountry = true;
      selectCountryError = "Please select country";
    } else if (phoneNumberController.text.trim().isEmpty) {
      phoneNumberError = "Please enter the number";
      print(countryCode + countryName);
    } else if (phoneNumberController.text.trim().length < 10) {
      phoneNumberError = "Please enter number greater then 10 digits";
    } else if (phoneNumberController.text.trim().length > 15) {
      phoneNumberError = "Please enter valid number";
    } else {
      phoneNumberError = "";
      shimmerEffectLogin = true;
      await phoneAuthentication();
      shimmerEffectLogin = false;
    }
    update();
  }

  Future<void> validationOtp() async {
    if (otp1.text.trim().isNotEmpty &&
        otp2.text.trim().isNotEmpty &&
        otp3.text.trim().isNotEmpty &&
        otp4.text.trim().isNotEmpty &&
        otp5.text.trim().isNotEmpty &&
        otp6.text.trim().isNotEmpty &&
        1 < start) {
      otpError = " ";
      shimmerEffectOtp = true;
      await verifyOTPCode();
      shimmerEffectOtp = false;
    } else {
      otpValidColor = false;
      otpError = "Please enter Otp";
    }
    update();
  }

  Future resendOtp() async {
    if (start == 0) {
      otp1.clear();
      otp2.clear();
      otp3.clear();
      otp4.clear();
      otp5.clear();
      otp6.clear();
      otpError = " ";
      await resendOTP();
      otpError = "Otp resend done..!";
    }
    update();
  }

  Future phoneAuthentication() async {
    //auth.setSettings(appVerificationDisabledForTesting: true,forceRecaptchaFlow: false);
    auth.verifyPhoneNumber(
      phoneNumber: "+${countryCode + phoneNumberController.text}",
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      timeout: const Duration(seconds: 49),
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  onVerificationCompleted(PhoneAuthCredential authCredential) async {
    await auth.signInWithCredential(authCredential).then(
          (value) => print('Logged In Successfully'),
        );
  }

  onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'Enter phone number entered is invalid!') {
      phoneNumberError = exception.code;
      update();
      print("The phone number entered is invalid!");
    }
  }

  onCodeSent(String verificationIds, int? forceResendingToken) {
    receivedID = verificationIds;
    forceResendingTokenNew = forceResendingToken;
    Get.toNamed(otpScreen)?.then((value) {
      clear();
    });
    startTimer();
    print("code sent");
  }

  codeAutoRetrievalTimeout(String verificationId) {
    print('TimeOut');
  }

  Future verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID!,
      smsCode: otp1.text.trim() +
          otp2.text.trim() +
          otp3.text.trim() +
          otp4.text.trim() +
          otp5.text.trim() +
          otp6.text.trim(),
    );

    try{
      await auth.signInWithCredential(credential);
      Get.showSnackbar(
        GetSnackBar(
          borderRadius: 15,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 20),
          message: 'User Registered Successfully',
          icon: const Image(
            image: AssetImage(
              Assets.imagesLoginsnackbar,
            ),
            height: 25,
            width: 20,
            color: ColorConstants.cFFFFFF,
            fit: BoxFit.fill,
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: ColorConstants.c1F61E8,
        ),
      );
      Get.toNamed(profileSetupScreen);
    }catch(e){
      Get.showSnackbar(
        GetSnackBar(
          borderRadius: 15,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 20),
          message: "Invalid otp",
          icon: const Image(
            image: AssetImage(
              Assets.imagesLoginsnackbar,
            ),
            height: 25,
            width: 20,
            color: ColorConstants.cFFFFFF,
            fit: BoxFit.fill,
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: ColorConstants.cE21A27,
        ),
      );
    }
  }

  Future resendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+${countryCode + phoneNumberController.text}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        start = 49;
        startTimer();
        otpValidColor = true;
        otpError = "OTP resend successfully";
      },
      timeout: const Duration(seconds: 49),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void clear() {
    phoneNumberController.clear();
    otp1.clear();
    otp2.clear();
    otp3.clear();
    otp4.clear();
    otp5.clear();
    otp6.clear();
    update();
  }

  @override
  void onInit() {
    validationPhoneNumber();
    selectCountryError = "";
    super.onInit();
  }
}
