import 'dart:io';

import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/chat_screen/controller/chat_screen_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/arguments_model.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewGroupScreen extends StatelessWidget {
  NewGroupScreen({super.key});

  var controller = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController());

  Future getData() async {
    var collection = FireBaseConstants.fireStore.collection('User');
    var querySnapshot = await collection.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      UserModel userModel = UserModel.fromJson(querySnapshot.docs[i].data());
      FireBaseConstants.fireStore
          .collection('User')
          .doc(userModel.uid)
          .update({"isMemberSelected": false});
    }
  }

  @override
  Widget build(BuildContext context) {
    getData().then((value) {
      controller.totalMembers = 0;
      controller.update();
    });

    return Scaffold(
      body: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (value) => Stack(
          children: [
            ///------top heading
            Container(
              height: 0.140.sh,
              width: 1.sw,
              color: ColorConstants.c1F61E8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    backButton(context: context),
                    Text(
                      StringConstants.kNewGroup,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        //Get.toNamed(groupProfileScreen);
                        if (controller.totalMembers > 1) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return groupSetupShowDialog(context: context);
                              });
                        } else {
                          Get.snackbar(
                            'Group',
                            'Please add members more then one..!',
                            snackStyle: SnackStyle.FLOATING,
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: ColorConstants.cFFFFFF,
                            margin: const EdgeInsets.symmetric(horizontal: 20)
                                .copyWith(bottom: 25),
                            backgroundColor: ColorConstants.cE21A27,
                            borderRadius: 20,
                            animationDuration: const Duration(seconds: 1),
                            duration: const Duration(seconds: 2),
                          );
                        }
                      },
                      child: Text(
                        StringConstants.kDone,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///------screen ui
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Column(
                children: [
                  Container(
                    height: 0.065.sh,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ).copyWith(top: 95),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: _searchBar(
                        textEditController: controller.newGroupSearchController,
                        textInputType: TextInputType.text,
                        icon: Assets.imagesSearchIcon,
                        focusNode: FocusNode(),
                        filledColor: ColorConstants.cFFFFFF,
                        hint: StringConstants.kSearch,
                        maxLines: 1),
                  ),
                  space30(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 1.sh,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          color: ColorConstants.cFFFFFF,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                space20(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      StringConstants.kContacts,
                                      style: TextStyle(
                                        color: ColorConstants.c1C2439,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${controller.totalMembers} Selected",
                                      style: TextStyle(
                                        color: ColorConstants.c626B84,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                space15(),
                                Expanded(
                                  child: ScrollConfiguration(
                                    behavior: NoGlowHelper(),
                                    child: StreamBuilder(
                                        stream: FireBaseConstants.fireStore
                                            .collection('User')
                                            .where('uid',
                                                isNotEqualTo: FireBaseConstants
                                                    .auth.currentUser!.uid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var querySnapShot = snapshot.data;
                                            return ListView.separated(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero
                                                  .copyWith(bottom: 30),
                                              itemCount:
                                                  querySnapShot!.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                UserModel userModel =
                                                    UserModel.fromJson(
                                                        querySnapShot
                                                            .docs[index]
                                                            .data());
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      userModel
                                                                          .profileImageUrl
                                                                          .toString()),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    userModel
                                                                        .name
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: ColorConstants
                                                                            .c1C2439,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            12.sp),
                                                                  ),
                                                                  space05(),
                                                                  Text(
                                                                    userModel
                                                                        .aboutMe
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color: ColorConstants
                                                                          .c626B84,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          10.sp,
                                                                    ),
                                                                    maxLines: 1,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          if (userModel
                                                                  .isMemberSelected ==
                                                              false) {
                                                            controller
                                                                .totalMembers++;
                                                            await FireBaseConstants
                                                                .fireStore
                                                                .collection(
                                                                    'User')
                                                                .doc(userModel
                                                                    .uid)
                                                                .update({
                                                              "isMemberSelected":
                                                                  true
                                                            });
                                                          } else {
                                                            controller
                                                                .totalMembers--;
                                                            await FireBaseConstants
                                                                .fireStore
                                                                .collection(
                                                                    'User')
                                                                .doc(userModel
                                                                    .uid)
                                                                .update({
                                                              "isMemberSelected":
                                                                  false
                                                            });
                                                          }
                                                          controller.update();
                                                        },
                                                        child: Image(
                                                          image: userModel
                                                                      .isMemberSelected ==
                                                                  false
                                                              ? const AssetImage(
                                                                  Assets
                                                                      .imagesCheckBox)
                                                              : const AssetImage(
                                                                  Assets
                                                                      .imagesFilledCheckBox),
                                                          fit: BoxFit.fill,
                                                          height: 22,
                                                          width: 22,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const Divider();
                                              },
                                            );
                                          } else {
                                            return const CircularProgressIndicator(
                                              color: Colors.blue,
                                            );
                                          }
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  groupSetupShowDialog({required BuildContext context}) {
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
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
                          StringConstants.kAddGroupDetails,
                          style: TextStyle(
                              color: ColorConstants.c1C2439,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          controller.groupProfileImage = null;
                          controller.updatedGroupProfileImage = null;
                          controller.groupNameError = "";
                          controller.newGroupNameController.text = "";
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.c626B84.withOpacity(0.2),
                          ),
                          child: const Image(
                            image: AssetImage(Assets.imagesCrossIcon),
                            height: 12,
                            width: 12,
                            fit: BoxFit.fill,
                            color: ColorConstants.c626B84,
                          ),
                        ),
                      )
                    ],
                  ),
                  space10(),
                  _imageUploadContainer(context: context),
                  space30(),
                  CustomTextFieldNameGroup(
                    textEditController: controller.newGroupNameController,
                    filled: true,
                    focusNode: FocusNode(),
                    textInputType: TextInputType.name,
                    label: StringConstants.kGroupName,
                    icon: Assets.imagesNewgroupIcon,
                    hint: StringConstants.kEnterGroupName,
                    maxLines: 1,
                    onChanged: (String) {
                      controller.validationGroupProfile();
                    },
                  ),

                  ///-----validations for the name
                  controller.groupNameError.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              controller.groupNameError,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  space30(),
                  Material(
                    color: Colors.transparent,
                    child: Center(
                        child: commonButton(
                            title: StringConstants.kDone,
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.validationGroupProfile();
                              var result = await FirebaseStorage.instance
                                  .ref(DateTime.timestamp().toString())
                                  .putFile(File(controller
                                      .updatedGroupProfileImage!.path));
                              controller.groupProfileImageUrl =
                                  await result.ref.getDownloadURL();

                              if (controller.totalMembers > 1 &&
                                  controller
                                      .newGroupNameController.text.isNotEmpty) {
                                var recieverName = [];
                                var recieverUid = [];
                                var fcmTokens = [];

                                var currentCollection = FireBaseConstants
                                    .fireStore
                                    .collection('User')
                                    .doc(FireBaseConstants
                                        .auth.currentUser!.uid);
                                DocumentSnapshot documentSnapshot =
                                    await currentCollection.get();
                                UserModel userModel = UserModel.fromJson(
                                    documentSnapshot.data()
                                        as Map<String, dynamic>);
                                recieverName.add(userModel.name);
                                recieverUid.add(userModel.uid);
                                fcmTokens.add(userModel.fcmToken);

                                var collection = FireBaseConstants.fireStore
                                    .collection('User');
                                var querySnapshot = await collection.get();
                                for (int i = 0;
                                    i < querySnapshot.docs.length;
                                    i++) {
                                  UserModel userModel = UserModel.fromJson(
                                      querySnapshot.docs[i].data());
                                  if (userModel.isMemberSelected == true) {
                                    recieverName.add(userModel.name);
                                    recieverUid.add(userModel.uid);
                                    fcmTokens.add(userModel.fcmToken);
                                  }
                                }

                                Get.offNamed(chatMessagingGroupScreen,
                                    arguments: GroupChatArgumnets(
                                      isCreated: false,
                                      fcmToken: fcmTokens,
                                      groupProfileImage:
                                          controller.groupProfileImageUrl,
                                      groupName: controller
                                          .newGroupNameController.text,
                                      recieverName: recieverName,
                                      recieverUid: recieverUid,
                                      docId: "",
                                    ))?.then((value) {
                                  getData();
                                  controller.totalMembers = 0;
                                  controller.newGroupNameController.clear();
                                  controller.groupProfileImageUrl = null;
                                  controller.updatedGroupProfileImage = null;
                                  controller.update();
                                });
                              }
                              // controller.validationGroupProfile();
                            })),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imageUploadContainer({required BuildContext context}) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        controller.updatedGroupProfileImage != null
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 33, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: ColorConstants.cECF4FF,
                  image: DecorationImage(
                      image: FileImage(controller.updatedGroupProfileImage),
                      fit: BoxFit.fill),
                ),
                child: const Image(
                  image: AssetImage(Assets.imagesProfileIcon),
                  fit: BoxFit.fill,
                  height: 30,
                  width: 23,
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 33, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: ColorConstants.cECF4FF,
                ),
                child: const Image(
                  image: AssetImage(Assets.imagesProfileIcon),
                  fit: BoxFit.fill,
                  height: 30,
                  width: 23,
                ),
              ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              ///---upload profile image
              ///
              showDialog(
                context: context,
                builder: (context) {
                  return addGroupProfileImageShowDialog(context: context);
                },
              );
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

  addGroupProfileImageShowDialog({required BuildContext context}) {
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
                    await controller.pickImageCameraGroup();
                    if (controller.groupProfileImage != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return groupProfileImagePreviewScreen(
                                image: controller.groupProfileImage);
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
                    await controller.pickImageGalleryGroup();
                    print("select image");
                    if (controller.groupProfileImage != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return groupProfileImagePreviewScreen(
                                image: controller.groupProfileImage);
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

  groupProfileImagePreviewScreen({required File image}) {
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
                      controller.updatedGroupProfileImage =
                          controller.groupProfileImage;
                      controller.update();
                      controller.groupProfileImage = null;
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
                      controller.updatedGroupProfileImage = null;
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

  _searchBar(
      {required TextEditingController textEditController,
      required TextInputType textInputType,
      required String? icon,
      required FocusNode focusNode,
      required Color? filledColor,
      required String? hint,
      required int maxLines}) {
    return Material(
      elevation: 4,
      color: ColorConstants.cFFFFFF,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: TextFormField(
          focusNode: focusNode,
          controller: textEditController,
          keyboardType: textInputType,
          maxLines: maxLines,
          style: const TextStyle(
              color: ColorConstants.c1C2439,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
                  .copyWith(bottom: 5),
              child: Image(
                image: AssetImage(icon!),
                height: 18,
                width: 18,
                color: ColorConstants.cA5C0F6,
                // fit: BoxFit.fill,
              ),
            ),
            filled: true,
            counterText: '',
            border: InputBorder.none,
            hintText: hint,
            fillColor: filledColor ?? ColorConstants.cECF4FF,
            hintStyle: const TextStyle(
                color: ColorConstants.cA5C0F6,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldNameGroup extends StatelessWidget {
  TextEditingController textEditController;
  TextInputType textInputType;
  String? icon;
  int maxLines;
  final Function(String) onChanged;

  // bool validate;
  String label;
  FocusNode focusNode;
  bool filled;
  Color? filledColor;
  String? hint;

  CustomTextFieldNameGroup({
    Key? key,
    required this.textEditController,
    required this.maxLines,
    required this.filled,
    required this.focusNode,
    required this.textInputType,
    required this.label,
    required this.onChanged,
    this.icon,
    this.filledColor,
    this.hint,
    // required this.validate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
        height: 60,
        // width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorConstants.cECF4FF,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Image.asset(
                icon.toString(),
                height: 22,
                width: 24,
                fit: BoxFit.fill,
                color: ColorConstants.c1F61E8,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      label,
                      style: const TextStyle(
                          color: ColorConstants.c626B84,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  space10(),
                  Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      focusNode: focusNode,
                      controller: textEditController,
                      keyboardType: textInputType,
                      maxLines: maxLines,
                      style: const TextStyle(
                          color: ColorConstants.c1C2439,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        filled: true,
                        counterText: '',
                        border: InputBorder.none,
                        hintText: hint,
                        fillColor: filledColor ?? ColorConstants.cECF4FF,
                        hintStyle: const TextStyle(
                            color: ColorConstants.c1C2439,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
