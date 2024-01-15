import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/chat_screen/model/story_model.dart';
import 'package:chatwave_flutter/chat_screen/screen/story_view_screen.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/key_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/firebase_services/services/firebase_services.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../chat_screen/model/initial_story_model.dart';
import '../../firebase_services/services/notification_services.dart';
import '../../utils/no_glow_helper.dart';

class SelfProfileScreen extends StatelessWidget {
  SelfProfileScreen({super.key});


  final controllerStory = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.cECF4FF,
      body: StreamBuilder(
          stream: FireBaseConstants.fireStore
              .collection(KeyConstants.kUser)
              .doc(FireBaseConstants.auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot documentSnapshot = snapshot.data!;
              UserModel userModel = UserModel.fromJson(
                  documentSnapshot.data() as Map<String, dynamic>);
              return Stack(
                children: [
                  Image(
                    image: const AssetImage(Assets.imagesProfileBack),
                    width: double.infinity,
                    height: 0.48.sh,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            space40(),
                            space10(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  StringConstants.kProfileDetails,
                                  style: TextStyleDecoration.s22w600cFFFFFF,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(editProfileScreen,
                                        arguments: userModel);
                                  },
                                  child: Image(
                                    image: AssetImage(
                                        Assets.imagesEditContainerIcon),
                                    height: 34,
                                    width: 34,
                                  ),
                                )
                              ],
                            ),
                            space20(),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return _viewProfilePic(
                                        image: userModel.profileImageUrl
                                            .toString(),
                                        name: userModel.name.toString());
                                  },
                                );
                              },
                              child: Container(
                                height: 0.12.sh,
                                width: 0.25.sw,
                                margin:
                                const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          userModel.profileImageUrl.toString()),
                                      fit: BoxFit.fill,
                                    ),
                                    color: Colors.transparent),
                              ),
                            ),
                            Text(
                              userModel.name.toString(),
                              style: TextStyleDecoration.s20w600cFFFFFF,
                            ),
                            space05(),
                            const Text(
                              StringConstants.kOnline,
                              style: TextStyleDecoration.s12w400c8FB0F4,
                            ),
                            space30(),
                            Row(
                              children: [
                                Text(
                                  userModel.aboutMe.toString(),
                                  style: TextStyleDecoration.s12w500cFFFFFF,
                                ),
                              ],
                            ),
                            space20(),
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  StringConstants.kStories,
                                  style: TextStyleDecoration.s16w600cFFFFFF,
                                )),
                            space15(),
                          ],
                        ),
                      ),
                      _myUserStory(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            space20(),

                            ///-----encryption tab
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                Get.toNamed(encryptionScreen);
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(15),
                                color: ColorConstants.cFFFFFF,
                                shadowColor: ColorConstants.cFFFFFF,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            Assets.imagesProfileEncrypt),
                                        height: 26,
                                        width: 26,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          space05(),
                                          const Text(
                                              StringConstants.kEncryption,
                                              style: TextStyleDecoration
                                                  .s14w400c1C2439),
                                          space10(),
                                          const Text(
                                            StringConstants
                                                .kProfileEncrpytionDescription,
                                            style: TextStyleDecoration
                                                .s10w400c626B84,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            space30(),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(15),
                              color: ColorConstants.cFFFFFF,
                              shadowColor: ColorConstants.cFFFFFF,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 7),
                                      child: Text(
                                        StringConstants.kEditProfile,
                                        style:
                                        TextStyleDecoration.s12w500c1C2439,
                                      ),
                                    ),
                                    const Divider(),
                                    InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return deleteShowDialog();
                                            });
                                      },
                                      child: const Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 7),
                                        child: Text(
                                          StringConstants.kDeleteAccount,
                                          style: TextStyleDecoration
                                              .s12w500cE21A27,
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () {
                                        FirebaseServices().signOut();
                                      },
                                      child: const Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 7),
                                        child: Text(
                                          StringConstants.kLogOut,
                                          style: TextStyleDecoration
                                              .s12w500cE21A27,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ));
            }
          }),
    );
  }

  _viewProfilePic({required String image, required String name}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: ColorConstants.cFFFFFF,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image(
                  image: NetworkImage(image),
                  height: 250,
                  width: 300,
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: ColorConstants.c1F61E8,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
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
            )
          ],
        ),
      ),
    );
  }

  _myUserStory() {
    return SizedBox(
      height: 75,
      child: StreamBuilder(
          stream: FireBaseConstants.fireStore
              .collection(KeyConstants.kStory)
              .doc(FireBaseConstants.auth.currentUser!.uid)
              .collection(KeyConstants.kUserStories)
              .orderBy(KeyConstants.kDateTime)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot querySnapshot =
              snapshot.data as QuerySnapshot<Object?>;
              if (querySnapshot.docs.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (context, index) {
                    StoryModel storyModel = StoryModel.fromJson(
                        querySnapshot.docs[index].data()
                        as Map<String, dynamic>);
                    if ((DateTime.now().isBefore(
                        DateTime.parse(storyModel.dateTime!)
                            .add(Duration(days: 1))))) {
                      return InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    contentPadding: EdgeInsets.only(
                                        left: 10, top: 30, right: 10),
                                    actionsPadding:
                                    EdgeInsets.only(top: 30, bottom: 30),
                                    content: Text(
                                      'Delete Item',
                                      style: TextStyleDecoration.s20w400c1C2439,
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              FireBaseConstants.fireStore
                                                  .collection(
                                                  KeyConstants.kStory)
                                                  .doc(FireBaseConstants.auth
                                                  .currentUser!.uid)
                                                  .collection(
                                                  KeyConstants.kUserStories)
                                                  .doc(querySnapshot.docs[index].id).delete();
                                              Get.back();
                                              controller.update();
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                              ),
                                              child: Text(
                                                  StringConstants.kDelete,
                                                  style: TextStyleDecoration
                                                      .s16w600cFFFFFF
                                                      .copyWith(
                                                      color: Colors.red)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(5)),
                                                  color:
                                                  ColorConstants.cE9E9E9),
                                              child: Text(
                                                  StringConstants.kCancel,
                                                  style: TextStyleDecoration
                                                      .s16w600cFFFFFF
                                                      .copyWith(
                                                      color: ColorConstants
                                                          .c1C2439)),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                });
                          });
                        },
                        child: Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(left: 25, right: 5)
                              : const EdgeInsets.symmetric(horizontal: 5),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: ColorConstants.cFFFFFF,
                            dashPattern: const [25, 1],
                            radius: const Radius.circular(15),
                            strokeWidth: 2,
                            child: Container(
                              height: 73,
                              width: 73,
                              margin: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          storyModel.storyUrl.toString()),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                        ),
                      );
                    }
                    else {
                      return SizedBox();
                    }
                  },
                );
              } else {
                return SizedBox();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              );
            }
          }),
    );
  }

  deleteShowDialog() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.cFFFFFF,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              StringConstants.kDeleteAccounts,
              style: TextStyle(
                  color: ColorConstants.c1C2439,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              textAlign: TextAlign.center,
            ),
            space40(),
            const Text(
              StringConstants.kDeleteDescription,
              style: TextStyle(
                  color: ColorConstants.c626B84,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.5),
              textAlign: TextAlign.start,
            ),
            space20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 55, vertical: 15),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: ColorConstants.cE9E9E9),
                    child: const Text(StringConstants.kCancel,
                        style: TextStyle(
                            color: ColorConstants.c202020,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 55, vertical: 15),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: ColorConstants.cF9D1D4),
                    child: const Text(StringConstants.kDelete,
                        style: TextStyle(
                            color: ColorConstants.cE21A27,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
