import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {

  final TextEditingController phoneNumberControllerOld = TextEditingController();
  final TextEditingController phoneNumberControllerNew = TextEditingController();

  var phoneNumberErrorOld = "";
  var phoneNumberErrorNew = "";

  var isSelected = false;
  var showNotification = false;
  var isSoundClick = false;


  var countryNameOld = '';
  var countryCodeOld = '';
  bool selectCountryOld = false;
  var selectCountryErrorOld ='';

  var countryNameNew = '';
  var countryCodeNew = '';
  bool selectCountryNew = false;
  var selectCountryErrorNew ='';



  List soundType = [
    "None",
    "Beep",
    "Sound",
    "Sound & Vibrate",
    "Sound then Vibrate"
  ];

  List privacySeen = [
    "Everyone",
    "My Contacts",
    "Nobody",
    "My Contacts Except",
    "Only Share With"
  ];



  validationPhoneNumberOld() async {
    if(countryNameOld.isEmpty && countryCodeOld.isEmpty){
      selectCountryOld = true;
      selectCountryErrorOld = "Please select country";
    }else
    if (phoneNumberControllerOld.text.trim().isEmpty) {
      phoneNumberErrorOld = "Please enter the number";
    } else if (phoneNumberControllerOld.text.trim().length < 10) {
      phoneNumberErrorOld = "Please enter number greater then 10 digits";
    } else if (phoneNumberControllerOld.text.trim().length > 15) {
      phoneNumberErrorOld = "Please enter valid number";
    } else {
      phoneNumberErrorOld = "";
      await validationPhoneNumberNew();
    }
    update();
  }

  validationPhoneNumberNew() async {
    if(countryNameNew.isEmpty && countryCodeNew.isEmpty){
      selectCountryNew = true;
      selectCountryErrorNew = "Please select country";
    }else
    if (phoneNumberControllerNew.text.trim().isEmpty) {
      phoneNumberErrorNew = "Please enter the number";
    } else if (phoneNumberControllerNew.text.trim().length < 10) {
      phoneNumberErrorNew = "Please enter number greater then 10 digits";
    } else if (phoneNumberControllerNew.text.trim().length > 15) {
      phoneNumberErrorNew = "Please enter valid number";
    } else {
      phoneNumberErrorNew = "";
    }
    update();
  }

  @override
  void onInit() {
    validationPhoneNumberOld();
    selectCountryErrorOld = '';
    validationPhoneNumberNew();
    selectCountryErrorNew = '';
    super.onInit();
  }
}
