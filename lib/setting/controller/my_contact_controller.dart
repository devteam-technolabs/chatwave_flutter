import 'package:chatwave_flutter/setting/model/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyContactController extends GetxController{
 TextEditingController searchController = TextEditingController();


 var contactModel =<ContactModel>[];
 var isSelected =false;


 @override
  void onInit() {
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "dsfdsgf", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Lofi", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Lofi", isShare: true));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "asdasd", isShare: true));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Lofi", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Loasdfi", isShare: true));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Lofi", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Losaffi", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "rewr", isShare: true));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Lofi", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "efdggdfg", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "sdferw", isShare: true));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Lofi", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "dsfewf", isShare: true));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "Lofi", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "ewrwedsc", isShare: true));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "ewrcdc", isShare: false));
  contactModel.add(ContactModel(image: "assets/images/contact_profile_image.png", name: "erwerew", isShare: false));
    super.onInit();
  }
}