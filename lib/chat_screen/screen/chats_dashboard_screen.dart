import 'dart:developer';
import 'dart:io';

import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/chat_screen/controller/chat_screen_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/arguments_model.dart';
import 'package:chatwave_flutter/chat_screen/model/initial_story_model.dart';
import 'package:chatwave_flutter/chat_screen/model/lastChat_model.dart';
import 'package:chatwave_flutter/chat_screen/model/story_model.dart';
import 'package:chatwave_flutter/chat_screen/screen/story_view_screen.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/firebase_services/services/firebase_services.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

import '../../constants/key_constants.dart';

class ChatsDashBoardScreen extends StatelessWidget {
  ChatsDashBoardScreen({super.key});

  var controller = Get.put(ChatController());
  final controllerStory = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.cECF4FF,
      body: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (value) => Column(
          children: [
            Container(
              color: ColorConstants.cECF4FF,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    padding: const EdgeInsets.only(bottom: 60),
                    decoration:
                        const BoxDecoration(color: ColorConstants.c1F61E8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        space40(),
                        _commonPadding(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  StringConstants.kChats,
                                  style: TextStyleDecoration.s26w600cFFFFFF,
                                ),
                                // const Spacer(),
                                Row(
                                  children: [
                                    InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () {
                                        Get.toNamed(newGroupScreen);
                                      },
                                      child: _iconContainer(
                                          iconImage: Assets.imagesGroupIcon),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () {
                                        Get.toNamed(allUsersChatScreen);
                                      },
                                      child: _iconContainer(
                                          iconImage: Assets.imagesChatTextPlus),
                                    )
                                  ],
                                )
                              ],
                            ),
                            space20(),
                            const Text(
                              StringConstants.kStories,
                              style: TextStyleDecoration.s16w600cFFFFFF,
                            ),
                          ],
                        )),
                        space15(),
                        Padding(
                            padding: const EdgeInsets.only().copyWith(top: 15),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  myStory(context: context),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  _otherUserStory(),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  _searchBar(
                      textEditController: controller.searchController,
                      textInputType: TextInputType.text,
                      icon: Assets.imagesSearchIcon,
                      focusNode: FocusNode(),
                      filledColor: ColorConstants.cFFFFFF,
                      hint: StringConstants.kSearch,
                      maxLines: 1),
                ],
              ),
            ),
            _chatRecords(),
          ],
        ),
      ),
    );
  }

  _commonPadding({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }

  _iconContainer({required String iconImage}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.cFFFFFF.withOpacity(0.2)),
      child: Image(
        image: AssetImage(iconImage),
        height: 14,
        width: 14,
        color: ColorConstants.cFFFFFF,
        fit: BoxFit.fill,
      ),
    );
  }

  _otherUserStory() {
    return StreamBuilder(
        stream: FireBaseConstants.fireStore
            .collection(KeyConstants.kStory)
            .orderBy(KeyConstants.kLatest, descending: true)
            .snapshots(),
        builder: (context, storySnapShot) {

          if (storySnapShot.hasData) {
            var querySnapShot = storySnapShot.data;
            return SizedBox(
                height: 73,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: querySnapShot?.docs.length,
                    itemBuilder: (context, index) {
                      InitialStoryModel initialStoryModel =
                          InitialStoryModel.fromJson(
                              querySnapShot!.docs[index].data());
                      print(initialStoryModel.time);
                      print(initialStoryModel.uid);
                      if (initialStoryModel.uid ==
                          FireBaseConstants.auth.currentUser!.uid) {
                        return SizedBox();
                      }
                      return  FutureBuilder(
                          future:
                          controller.userData(uid: initialStoryModel.uid!),
                          builder: (context, profileSnapShot) {
                            if (profileSnapShot.hasData) {

                              print(profileSnapShot.data);
                              bool exist=(DateTime.now()
                                  .isBefore(DateTime.parse(initialStoryModel.time!).add(Duration(days: 1))));
                              if(exist==false){
                                return SizedBox();
                              }
                              return InkWell(
                                splashFactory: NoSplash.splashFactory,
                                 onTap: () async {
                                  List<StoryItem> list=await controller.storyData(uid: profileSnapShot.data!.uid.toString(), controllerStory: controllerStory);
                                  if(list.isNotEmpty){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StoryViewScreen(
                                                name: profileSnapShot.data!.name.toString(),
                                                profileImage: profileSnapShot.data!.profileImageUrl.toString(),
                                                controller: controllerStory,
                                                storyItems: list,
                                              ),
                                        ));
                                  }
                            },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                              image: NetworkImage(profileSnapShot.data!.profileImageUrl.toString()),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                height: 73,
                                width: 73,
                                color: Colors.red,
                              );
                            }
                          });
                    }));
/*                   UserModel userModel =
                      UserModel.fromJson(querySnapShot!.docs[index].data());
                  userModel.story = [];
                  print('${userModel.story}After removing all');
                  var querySnapShotStory = querySnapShot.data;
                  StoryModel? storyModel;
                  if (querySnapShotStory!.docs.isNotEmpty) {
                    for (int i = 0;
                    i < querySnapShotStory.docs.length;
                    i++) {
                      storyModel = StoryModel.fromJson(
                          querySnapShotStory.docs[i].data());
                      if ((DateTime.now().isBefore(
                          DateTime.parse(storyModel.dateTime!)
                              .add(Duration(days: 1)))) &&
                          userModel.uid == storyModel.uid) {
                        userModel.story.add(
                          StoryItem.pageImage(
                              url: storyModel.storyUrl.toString(),
                              controller: controllerStory,
                              imageFit: BoxFit.fitWidth,
                              caption: storyModel.caption.toString(),
                              duration: const Duration(seconds: 5)),
                        );
                        print(userModel.story.toString() +
                            userModel.name.toString());
                      }
                    }
                    return userModel.story.isEmpty
                        ? SizedBox()
                        : InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StoryViewScreen(
                                    name: userModel.name.toString(),
                                    profileImage: userModel
                                        .profileImageUrl
                                        .toString(),
                                    controller: controllerStory,
                                    storyItems: userModel.story,
                                  ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5),
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
                                borderRadius:
                                BorderRadius.circular(15),
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: NetworkImage(userModel
                                        .profileImageUrl
                                        .toString()),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ),
                    );
                  }*/
          } else {
            return const CircularProgressIndicator(
              color: Colors.blue,
            );
          }
        });
  }

  myStory({required BuildContext context}) {
    return Stack(
      children: [
        InkWell(
          child: StreamBuilder(
            stream: FireBaseConstants.fireStore
                .collection(KeyConstants.kStory).where(KeyConstants.kUid,isEqualTo: FireBaseConstants.auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
                var querySnapShot = snapshot.data;
                InitialStoryModel initialStoryModel =
                InitialStoryModel.fromJson(
                    querySnapShot!.docs.first.data());
                return FutureBuilder(
                    future:
                    controller.userData(uid: initialStoryModel.uid!),
                    builder: (context, profileSnapShot) {
                      if (profileSnapShot.hasData) {
                        return InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () async {
                            List<StoryItem> list=await controller.storyData(uid: profileSnapShot.data!.uid.toString(), controllerStory: controllerStory);
                            if(list.isNotEmpty){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StoryViewScreen(
                                          name: profileSnapShot.data!.name.toString(),
                                          profileImage: profileSnapShot.data!.profileImageUrl.toString(),
                                          controller: controllerStory,
                                          storyItems: list,
                                          isUSer: true,
                                        ),
                                  ));
                            }
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5),
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
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                        image: NetworkImage(profileSnapShot.data!.profileImageUrl.toString()),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 73,
                          width: 73,
                          color: Colors.red,
                        );
                      }
                    });
              }
              else{
                return  Container(color: Colors.red,height: 100,width: 100,);
              }
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              ///-----upload stories
              // _showDialog(context: context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return addStoryShowDialog(context: context);
                  });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.transparent,
                  ),
                ],
                border: Border.all(width: 2.5, color: ColorConstants.c1F61E8),
                color: ColorConstants.cFFFFFF,
              ),
              child: const Image(
                image: AssetImage(Assets.imagesAddIcon),
                fit: BoxFit.fill,
                height: 7,
                width: 7,
              ),
            ),
          ),
        ),
      ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Material(
        elevation: 5,
        color: ColorConstants.cFFFFFF,
        shadowColor: ColorConstants.cFFFFFF,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
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
                  padding: const EdgeInsets.all(12),
                  child: Image(
                    image: AssetImage(icon!),
                    height: 18,
                    width: 18,
                    color: ColorConstants.cA5C0F6,
                    fit: BoxFit.fill,
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                errorStyle: const TextStyle(
                    fontStyle: FontStyle.italic, color: ColorConstants.cFFFFFF),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorConstants.cFFFFFF, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorConstants.cFFFFFF, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
      ),
    );
  }

  _chatRecords() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: NoGlowHelper(),
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FireBaseConstants.fireStore
                  .collection("Chat")
                  .where("uid", arrayContainsAny: [
                FireBaseConstants.auth.currentUser!.uid
              ]).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var querySnapShot = snapshot.data;
                  return ListView.builder(
                    padding: EdgeInsets.zero.copyWith(bottom: 100),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: querySnapShot!.docs.length,
                    itemBuilder: (context, index) {
                      LastChat lastChat =
                          LastChat.fromJson(querySnapShot.docs[index].data());
                      int search = lastChat.uid!.indexWhere((element) {
                        return element ==
                            FireBaseConstants.auth.currentUser!.uid;
                      });

                      return StreamBuilder(
                          stream: FireBaseConstants.fireStore
                              .collection(KeyConstants.kUser)
                              .doc(lastChat.uid![search == 1 ? 0 : 1])
                              .snapshots(),
                          builder: (context, snapshotSecond) {
                            if (snapshotSecond.hasData) {
                              DocumentSnapshot docSnap = snapshotSecond.data
                                  as DocumentSnapshot<Object?>;
                              UserModel userModel = UserModel.fromJson(
                                  docSnap.data() as Map<String, dynamic>);
                              return InkWell(
                                onTap: () async {
                                  List<LastChat> lastChatList = [];
                                  var response1 = await FireBaseConstants
                                      .fireStore
                                      .collection('Chat')
                                      .where('uid',
                                          arrayContains: FireBaseConstants
                                              .auth.currentUser!.uid)
                                      .get();
                                  for (var u in response1.docs) {
                                    lastChatList
                                        .add(LastChat.fromJson(u.data()));
                                  }

                                  int search =
                                      lastChatList.indexWhere((element) {
                                    return element.uid!.contains(userModel.uid);
                                  });

                                  if (search != -1) {
                                    Get.toNamed(chatMessagingScreen,
                                        arguments: ChatArgumnets(
                                          docId: response1.docs[search].id,
                                          recieverId: userModel.uid.toString(),
                                          profileImage: userModel
                                              .profileImageUrl
                                              .toString(),
                                          recieverName:
                                              userModel.name.toString(),
                                          isCreated: true,
                                        ));
                                  } else {
                                    Get.toNamed(chatMessagingScreen,
                                        arguments: ChatArgumnets(
                                          recieverId: userModel.uid.toString(),
                                          profileImage: userModel
                                              .profileImageUrl
                                              .toString(),
                                          recieverName:
                                              userModel.name.toString(),
                                          isCreated: false,
                                        ));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Material(
                                    elevation: 3,
                                    shadowColor: ColorConstants.cFFFFFF,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      //margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.cFFFFFF,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: ColorConstants.cFFFFFF
                                                    .withOpacity(0.1),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        userModel
                                                            .profileImageUrl
                                                            .toString()))),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      userModel.name.toString(),
                                                      style: TextStyleDecoration
                                                          .s12w500c1C2439,
                                                    ),
                                                    (index % 2 == 0)
                                                        ? const Image(
                                                            image: AssetImage(
                                                                Assets
                                                                    .imagesRedDot),
                                                            height: 8,
                                                            width: 8,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                                space05(),
                                                const Text(
                                                  StringConstants.kJustNow,
                                                  style: TextStyleDecoration
                                                      .s10w400c626B84,
                                                ),
                                                space10(),
                                                const Text(
                                                  StringConstants.kChatsChat,
                                                  style: TextStyleDecoration
                                                      .s10w400c1C2439,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          });
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  addStoryShowDialog({required BuildContext context}) {
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
                const Text(
                  StringConstants.kAddStory,
                  style: TextStyle(
                      color: ColorConstants.c1C2439,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                  textAlign: TextAlign.center,
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
            const Text(
              StringConstants.kStoryDescription,
              style: TextStyle(
                  color: ColorConstants.c626B84,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.5),
              textAlign: TextAlign.start,
            ),
            space30(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await controller.pickImageCamera();
                      if (controller.imageStory != null) {
                        showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return storyPreviewScreen(
                                  image: controller.imageStory,
                                  context: context);
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
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: ColorConstants.c1F61E8.withOpacity(0.7)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                SizedBox(
                  width: 0.02.sw,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await controller.pickImageGallery();
                      print("select image");
                      if (controller.imageStory != null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return storyPreviewScreen(
                                  image: controller.imageStory,
                                  context: context);
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
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: ColorConstants.c1F61E8.withOpacity(0.7)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  storyPreviewScreen({required File image, required BuildContext context}) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: 1.sh,
        width: double.infinity,
        child: ScrollConfiguration(
          behavior: NoGlowHelper(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 0.7.sh,
                  width: double.infinity,
                  // color: Colors.blue.withOpacity(0.5),
                  color: Colors.black,
                  child: Image.file(image),
                ),
                _captionTextField(
                    textEditController: controller.captionController,
                    textInputType: TextInputType.text,
                    icon: Assets.imagesCaptionAddIcon,
                    focusNode: FocusNode(),
                    filledColor: ColorConstants.cFFFFFF,
                    hint: StringConstants.kAddCaption,
                    maxLines: 1),
                Container(
                  height: 0.15.sh,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: ColorConstants.cFFFFFF,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            await FirebaseServices().addingUserStory();
                            controller.imageStory = null;
                            controller.captionController.clear();
                            controller.update();
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
                            FocusScope.of(context).unfocus();
                            Get.back();
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
          ),
        ),
      ),
    );
  }

  _captionTextField(
      {required TextEditingController textEditController,
      required TextInputType textInputType,
      required String? icon,
      required FocusNode focusNode,
      required Color? filledColor,
      required String? hint,
      required int maxLines}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Material(
        elevation: 5,
        color: ColorConstants.cFFFFFF,
        shadowColor: ColorConstants.cFFFFFF,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TextFormField(
            scrollPadding: EdgeInsets.only(bottom: 0.25.sh),
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
                  padding: const EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(icon!),
                    height: 20,
                    width: 20,
                    color: ColorConstants.cA5C0F6,
                    fit: BoxFit.fill,
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                errorStyle: const TextStyle(
                    fontStyle: FontStyle.italic, color: ColorConstants.cFFFFFF),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorConstants.cFFFFFF, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorConstants.cFFFFFF, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
      ),
    );
  }
}
