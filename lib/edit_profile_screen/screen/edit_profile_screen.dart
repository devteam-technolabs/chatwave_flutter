import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../constants/text_style_constants.dart';
import 'dart:io';
import '../../generated/assets.dart';
import '../../utils/custom_textfields.dart';
import '../../utils/helping_widgets.dart';
import '../../utils/no_glow_helper.dart';
class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({super.key});


  var controller=Get.put(EditProfileController());
  UserModel userModel =Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.nameController.text=userModel.name!;
    controller.descriptionController.text=userModel.aboutMe!;
    controller.url=userModel.profileImageUrl!;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowHelper(),
        child: SingleChildScrollView(
          child: GetBuilder(
            init: controller,
            builder: (value) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    const Image(
                      image: AssetImage(Assets.imagesOtpScreenBackground),
                      height: 152,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 40),
                      child: backButton(context: context),
                    ),
                  ],
                ),
                _profileSetupView(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _profileSetupView({required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                StringConstants.kEditProfile,
                style: TextStyleDecoration.s20w400c1C2439,
              ),
              space30(),
              _imageUploadContainer(context: context),

              ///-----validations for the image
              controller.imageError.isNotEmpty
                  ? Column(
                children: [
                  space10(),
                  Text(
                    controller.imageError,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
                  : Container(),
              space20(),
              CustomTextFieldName(
                textEditController: controller.nameController,
                filled: true,
                focusNode: FocusNode(),
                textInputType: TextInputType.name,
                label: StringConstants.kName,
                icon: Assets.imagesNameIcon,
                hintExist: true,
                hint: StringConstants.kEnterName,
                isImage: true,
                maxLines: 1,
              ),

              ///-----validations for the name
              controller.nameError.isNotEmpty
                  ? Column(
                children: [
                  space10(),
                  Text(
                    controller.nameError,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
                  : Container(),
              space20(),
              CustomTextFieldName(
                textEditController: controller.descriptionController,
                filled: true,
                focusNode: FocusNode(),
                textInputType: TextInputType.multiline,
                label: StringConstants.kAboutMeOptional,
                hintExist: true,
                hint: StringConstants.kTypeHere,
                isImage: false,
                maxLines: 4,
              ),
              space30(),
              Center(
                  child: commonButton(
                      title: StringConstants.kDone,
                      onTap: () {
                        controller.validationProfileImage();

                      }))
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(top: 90),
          child: const Text(
            StringConstants.kV10AllRightsReserved,
            style: TextStyleDecoration.s10w400cD2D2D2,
          ),
        )
      ],
    );
  }

  _imageUploadContainer({required BuildContext context}) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        controller.updatedProfileImage!=null?Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorConstants.cECF4FF,
              image: DecorationImage(
                image: FileImage(controller.updatedProfileImage!),
                fit: BoxFit.fill,
              )),
        )
            :
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorConstants.cECF4FF,
              image: DecorationImage(
                image: NetworkImage(controller.url),
                fit: BoxFit.fill,
              )),
        ),

        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              ///---upload profile image
              // _showDialog(context: context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return addProfileImageShowDialog(context: context);});
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.transparent,
                  ),
                ],
                border: Border.all(width: 2.5, color: ColorConstants.cFFFFFF),
                color: ColorConstants.c1F61E8,
              ),
              child: const Image(
                image: AssetImage(Assets.imagesEditIcon),
                fit: BoxFit.fill,
                height: 14,
                width: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showDialog({required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.transparent)),
            contentPadding: const EdgeInsets.only(left: 50, top: 30, right: 50),
            actionsPadding: const EdgeInsets.only(top: 30, bottom: 30),
            content: const Text(
              StringConstants.kSelectImage,
              style: TextStyle(
                  color: ColorConstants.c1F61E8,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
            actions: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await controller.pickImageCamera();
                          controller.update();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              color: ColorConstants.c1F61E8),
                          child: const Text(StringConstants.kCamera,
                              style: TextStyle(
                                  color: ColorConstants.cFFFFFF, fontSize: 18)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.pickImageGallery();
                          controller.update();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              color: ColorConstants.c1F61E8),
                          child: const Text(StringConstants.kGallery,
                              style: TextStyle(
                                  color: ColorConstants.cFFFFFF, fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                  space20(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            controller.update();
                          },
                          child: const Text(
                            StringConstants.kCancel,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        });
  }


  addProfileImageShowDialog({required BuildContext context}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.cFFFFFF,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Material(
                  color: Colors.transparent,
                  child: Text(
                    StringConstants.kAddProfileImage,
                    style: TextStyle(
                        color: ColorConstants.c1C2439,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      shadowColor: Colors.red,
                      child: const Image(
                        image: AssetImage(Assets.imagesCancelIcon),
                        height: 25,
                        width: 25,
                        fit: BoxFit.fill,
                      )),
                )
              ],
            ),
            space20(),
            const Material(
              color: Colors.transparent,
              child: Text(
                StringConstants.kProfileImageDescription,
                style: TextStyle(
                    color: ColorConstants.c626B84,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5),
                textAlign: TextAlign.start,
              ),
            ),
            space30(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await controller.pickImageCamera();
                    if (controller.profileImage != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return profileImagePreviewScreen(
                                image: controller.profileImage);
                          });
                    } else {
                      Get.back();
                    }
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    shadowColor: ColorConstants.cFFFFFF,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.08.sw, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(6)),
                          color: ColorConstants.c1F61E8.withOpacity(0.7)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage(Assets.imagesPhotoCamera),
                            height: 20,
                            width: 25,
                            fit: BoxFit.fill,
                            color: ColorConstants.cFFFFFF,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(StringConstants.kCamera,
                              style: TextStyle(
                                  color: ColorConstants.cFFFFFF,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 0.02.sw,
                ),
                GestureDetector(
                  onTap: () async {
                    await controller.pickImageGallery();
                    print("select image");
                    if (controller.profileImage != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return profileImagePreviewScreen(
                                image: controller.profileImage);
                          });
                    } else {
                      Get.back();
                    }
                    print("image uploaded");
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    shadowColor: ColorConstants.cFFFFFF,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.09.sw, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(6)),
                          color: ColorConstants.c1F61E8.withOpacity(0.7)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage(Assets.imagesGallery),
                            height: 20,
                            width: 25,
                            fit: BoxFit.fill,
                            color: ColorConstants.cFFFFFF,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(StringConstants.kGallery,
                              style: TextStyle(
                                  color: ColorConstants.cFFFFFF,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  profileImagePreviewScreen({required File image}) {
    return Container(
      color: Colors.white,
      height: 1.sh,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 0.8.sh,
            width: double.infinity,
            color: Colors.blue.withOpacity(0.5),
            child: Image.file(image),
          ),
          Container(
            height: 0.15.sh,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: const BoxDecoration(
              color: ColorConstants.cFFFFFF,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      controller.updatedProfileImage = controller.profileImage;
                      controller.update();
                      controller.profileImage = null;
                      Get.back();
                    },
                    child: Image.asset(
                      Assets.imagesChecked,
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    )),
                GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.updatedProfileImage = null;
                      controller.update();
                    },
                    child: Image.asset(
                      Assets.imagesCancelImageIcon,
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

}
