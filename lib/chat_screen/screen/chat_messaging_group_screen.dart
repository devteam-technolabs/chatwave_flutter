import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/chat_screen/controller/chat_screen_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/currentChatGroup.dart';
import 'package:chatwave_flutter/chat_screen/model/currentChat_model.dart';
import 'package:chatwave_flutter/chat_screen/model/lastChatGroup_model.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/firebase_services/services/notification_services.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../model/arguments_model.dart';

class ChatMessagingGroupScreen extends StatelessWidget {
  ChatMessagingGroupScreen({super.key});

  var controller = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController());

  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  GroupChatArgumnets arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.scrollChat = true;
    return Scaffold(
      backgroundColor: ColorConstants.cECF4FF,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _appBar(context: context),
          Expanded(child: _chatsMessages()),
          _bottomButtons(),
        ],
      ),
    );
  }

  _chatsMessages() {
    return ScrollConfiguration(
      behavior: NoGlowHelper(),
      child: GetBuilder(
          init: ChatController(),
          builder: (ctx) {
            return StreamBuilder(
              stream: firestore
                  .collection('GroupChat')
                  .doc(arguments.docId)
                  .collection('CurrentChatGroup')
                  .orderBy('dateTime')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var querySnapShot = snapshot.data;
                  controller.chatCount = querySnapShot!.docs.length;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    controller: controller.scroll,
                    itemCount: controller.chatCount,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      CurrentChat currentChat = CurrentChat.fromJson(
                          querySnapShot!.docs[index].data());
                      if (controller.scrollChat) {
                        refreshChat();
                        controller.scrollChat = false;
                      }
                      DateTime t =
                          DateTime.parse(currentChat.dateTime.toString());
                      Duration time = DateTime.now().difference(t);
                      getTime({required double seconds}) {
                        String time;
                        double? minutes;
                        double? hours;
                        double? days;
                        if (seconds >= 60) {
                          minutes = seconds / 60;
                          seconds = seconds % 60;
                          if (minutes >= 60) {
                            hours = minutes / 60;
                            minutes = minutes % 60;
                            time = '${hours.toInt()}${" hour ago"}';
                            if (hours >= 24) {
                              days = hours / 24;
                              return time = '${days?.toInt()}${" days ago"}';
                            }
                            return time;
                          } else {
                            time = '${minutes.toInt()}${" minutes ago"}';
                            return time;
                          }
                        }
                        // time = '${seconds.toInt()}${" seconds ago"}';
                        time = "Just now";
                        return time;
                      }

                      return Column(
                        crossAxisAlignment:
                            currentChat.sendByUid != _auth.currentUser!.uid
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                        children: [
                          currentChat.sendByUid != _auth.currentUser!.uid
                              ? Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.60,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color:
                                                      ColorConstants.cFFFFFF),
                                              child: Text(
                                                currentChat.message.toString(),
                                                style: const TextStyle(
                                                    height: 1.5,
                                                    letterSpacing: 0.7,
                                                    color:
                                                        ColorConstants.c1C2439,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Image(
                                            image: AssetImage(
                                                Assets.imagesThreeDotsIcon),
                                            height: 4,
                                            width: 18,
                                            fit: BoxFit.fill,
                                          )
                                        ],
                                      ),
                                      space10(),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            getTime(
                                                seconds:
                                                    time.inSeconds.toDouble()),
                                            style: TextStyleDecoration
                                                .s10w400c626B84,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  // color: Colors.red,
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.60,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              PopupMenuButton(
                                                elevation: 10,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0))),
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  _buildPopupMenuItem(
                                                      title:
                                                          StringConstants.kEdit,
                                                      imageColor: ColorConstants
                                                          .c1C2439,
                                                      textColor: ColorConstants
                                                          .c1C2439,
                                                      image: Assets
                                                          .imagesChatEditIcon,
                                                      onTap: () {}),
                                                  _buildPopupMenuItem(
                                                      title: StringConstants
                                                          .kReply,
                                                      imageColor: ColorConstants
                                                          .c1C2439,
                                                      textColor: ColorConstants
                                                          .c1C2439,
                                                      image: Assets
                                                          .imagesChatReplyIcon,
                                                      onTap: () {}),
                                                  _buildPopupMenuItem(
                                                      title:
                                                          StringConstants.kEdit,
                                                      imageColor: ColorConstants
                                                          .cE21A27,
                                                      textColor: ColorConstants
                                                          .cE21A27,
                                                      image: Assets
                                                          .imagesChatDeleteIcon,
                                                      onTap: () {}),
                                                ],
                                                child: const Image(
                                                  image: AssetImage(Assets
                                                      .imagesThreeDotsIcon),
                                                  height: 4,
                                                  width: 18,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.60 -
                                                          0.04.sh,
                                                ),
                                                // alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: ColorConstants.c1C2439,
                                                ),
                                                child: Text(
                                                  currentChat.message
                                                      .toString(),
                                                  style: const TextStyle(
                                                      height: 1.5,
                                                      letterSpacing: 0.7,
                                                      color: ColorConstants
                                                          .cFFFFFF,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          space10(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, left: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  getTime(
                                                      seconds: time.inSeconds
                                                          .toDouble()),
                                                  style: TextStyleDecoration
                                                      .s10w400c626B84,
                                                ),
                                                //const Spacer(),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Row(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(Assets
                                                          .imagesReadmsgIcon),
                                                      height: 7,
                                                      width: 13,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      StringConstants.kRead,
                                                      style: TextStyleDecoration
                                                          .s10w400c1F61E8,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.deepPurple),
                  );
                }
              },
            );
          }),
    );
  }

  _bottomButtons() {
    return GetBuilder(
        init: ChatController(),
        builder: (ctx) {
          return StreamBuilder(
            stream: firestore
                .collection('User')
                .doc(_auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                DocumentSnapshot? documentSnapshot = snapshot.data;
                UserModel userModel = UserModel.fromJson(
                    documentSnapshot!.data() as Map<String, dynamic>);
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ).copyWith(bottom: 15),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${arguments.recieverName} typing...",
                        style: TextStyleDecoration.s10w400cA5C0F6,
                      ),
                      space05(),
                      Material(
                        borderRadius: BorderRadius.circular(14),
                        color: ColorConstants.cFFFFFF,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                  Assets.imagesMicIcon,
                                ),
                                height: 14,
                                width: 14,
                                fit: BoxFit.fill,
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    controller.groupMessageText = value;
                                    controller.update();
                                  },
                                  controller: controller.groupChatController,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    hintText: StringConstants.kTypeHere,
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: ColorConstants.c626B84,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const Image(
                                image: AssetImage(
                                  Assets.imagesDocumentIcon,
                                ),
                                height: 14,
                                width: 14,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorConstants.c1F61E8
                                        .withOpacity(0.2)),
                                child: const Image(
                                  image:
                                      AssetImage(Assets.imagesMultipleFileIcon),
                                  height: 15,
                                  width: 15,
                                  color: ColorConstants.c1F61E8,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              controller.groupChatController.text.isNotEmpty
                                  ? InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () async {
                                        if (controller.groupChatController.text
                                            .isNotEmpty) {
                                          if (arguments.isCreated == true) {
                                            firestore
                                                .collection("GroupChat")
                                                .doc(arguments.docId)
                                                .set(LastChatGroup(
                                                        uid: arguments
                                                            .recieverUid,
                                                        groupMembersName:
                                                            arguments
                                                                .recieverName,
                                                        groupCreatedBy: userModel
                                                            .name,
                                                        fcmTokens:
                                                            arguments.fcmToken,
                                                        lastMsg: controller
                                                            .groupChatController
                                                            .text,
                                                        lastMsgBy:
                                                            userModel.name,
                                                        lastMsgByUid: _auth
                                                            .currentUser!.uid,
                                                        lastMsgTime:
                                                            DateTime.timestamp()
                                                                .toString(),
                                                        docId: arguments.docId,
                                                        lastMsgIsImage: false,
                                                        lastMsgIsAudio: false,
                                                        lastMsgIsVideo: false,
                                                        groupName:
                                                            arguments.groupName,
                                                        groupProfileImage:
                                                            arguments
                                                                .groupProfileImage)
                                                    .toJson());

                                            firestore
                                                .collection("GroupChat")
                                                .doc(arguments.docId)
                                                .collection("CurrentChatGroup")
                                                .doc()
                                                .set(CurrentChatGroup(
                                                  dateTime: DateTime.timestamp()
                                                      .toString(),
                                                  message: controller
                                                      .groupChatController.text,
                                                  sendBy: userModel.name,
                                                  sendByUid:
                                                      _auth.currentUser!.uid,
                                                  isImage: false,
                                                  isAudio: false,
                                                  isVideo: false,
                                                ).toJson())
                                                .then((value) => refreshChat());

                                            controller.fcmName = arguments
                                                .recieverName
                                                .toString();
                                            controller.fcmProfileImage =
                                                arguments.groupProfileImage
                                                    .toString();
                                            controller.fcmRecieverId = arguments
                                                .recieverUid
                                                .toString();
                                            controller.fcmDocId =
                                                arguments.docId.toString();
                                            controller.update();

                                            PushNotify().postNotification(
                                                token: arguments.fcmToken
                                                    .toString(),
                                                title:
                                                    userModel.name.toString(),
                                                subTitle: controller
                                                    .groupChatController.text);

                                            controller.groupChatController
                                                .clear();
                                            controller.update();
                                          } else {
                                            List<LastChatGroup> lastChatList =
                                                [];
                                            var response1 = await firestore
                                                .collection('GroupChat')
                                                .where('uid',
                                                    arrayContains:
                                                        _auth.currentUser!.uid)
                                                .get();
                                            for (var u in response1.docs) {
                                              lastChatList.add(
                                                  LastChatGroup.fromJson(
                                                      u.data()));
                                            }

                                            int search = lastChatList
                                                .indexWhere((element) {
                                              return element.uid!
                                                  .contains(userModel.uid);
                                            });
                                            log("found $search");

                                            if (search != -1 &&
                                                controller.chatCount != 0) {
                                              firestore
                                                  .collection("GroupChat")
                                                  .doc(
                                                      response1.docs[search].id)
                                                  .set(LastChatGroup(
                                                    uid: arguments.recieverUid,
                                                    groupMembersName:
                                                        arguments.recieverName,
                                                    groupCreatedBy:
                                                        userModel.name,
                                                    fcmTokens:
                                                        arguments.fcmToken,
                                                    lastMsg: controller
                                                        .groupChatController
                                                        .text,
                                                    lastMsgBy: userModel.name,
                                                    lastMsgByUid:
                                                        _auth.currentUser!.uid,
                                                    lastMsgTime:
                                                        DateTime.timestamp()
                                                            .toString(),
                                                    docId: response1
                                                        .docs[search].id,
                                                    lastMsgIsImage: false,
                                                    lastMsgIsAudio: false,
                                                    lastMsgIsVideo: false,
                                                    groupName:
                                                        arguments.groupName,
                                                    groupProfileImage: arguments
                                                        .groupProfileImage,
                                                  ).toJson());

                                              firestore
                                                  .collection("GroupChat")
                                                  .doc(
                                                      response1.docs[search].id)
                                                  .collection(
                                                      "CurrentChatGroup")
                                                  .doc()
                                                  .set(CurrentChatGroup(
                                                    dateTime:
                                                        DateTime.timestamp()
                                                            .toString(),
                                                    message: controller
                                                        .groupChatController
                                                        .text,
                                                    sendBy: userModel.name,
                                                    sendByUid:
                                                        _auth.currentUser!.uid,
                                                    isImage: false,
                                                    isAudio: false,
                                                    isVideo: false,
                                                  ).toJson())
                                                  .then(
                                                      (value) => refreshChat());

                                              arguments.docId =
                                                  response1.docs[search].id;

                                              controller.fcmName = arguments
                                                  .recieverName
                                                  .toString();
                                              controller.fcmProfileImage =
                                                  arguments.groupProfileImage
                                                      .toString();
                                              controller.fcmRecieverId =
                                                  arguments.recieverUid
                                                      .toString();
                                              controller.fcmDocId =
                                                  arguments.docId.toString();
                                              controller.update();

                                              PushNotify().postNotification(
                                                  token: arguments.fcmToken
                                                      .toString(),
                                                  title:
                                                      userModel.name.toString(),
                                                  subTitle: controller
                                                      .groupChatController
                                                      .text);
                                              controller.groupChatController
                                                  .clear();
                                              controller.update();
                                            } else if (controller.chatCount ==
                                                0) {
                                              await firestore
                                                  .collection("GroupChat")
                                                  .add(LastChatGroup(
                                                    uid: arguments.recieverUid,
                                                    groupMembersName:
                                                        arguments.recieverName,
                                                    groupCreatedBy:
                                                        userModel.name,
                                                    fcmTokens:
                                                        arguments.fcmToken,
                                                    lastMsg: controller
                                                        .groupChatController
                                                        .text,
                                                    lastMsgBy: userModel.name,
                                                    lastMsgByUid:
                                                        _auth.currentUser!.uid,
                                                    lastMsgTime:
                                                        DateTime.timestamp()
                                                            .toString(),
                                                    lastMsgIsImage: false,
                                                    lastMsgIsAudio: false,
                                                    lastMsgIsVideo: false,
                                                    groupName:
                                                        arguments.groupName,
                                                    groupProfileImage: arguments
                                                        .groupProfileImage
                                                        .toString(),
                                                  ).toJson())
                                                  .then((value) async {
                                                arguments.docId = value.id;
                                                controller.update();
                                                await firestore
                                                    .collection("GroupChat")
                                                    .doc(value.id)
                                                    .collection(
                                                        "CurrentChatGroup")
                                                    .doc()
                                                    .set(CurrentChatGroup(
                                                      dateTime:
                                                          DateTime.timestamp()
                                                              .toString(),
                                                      message: controller
                                                          .groupChatController
                                                          .text,
                                                      sendBy: userModel.name,
                                                      sendByUid: _auth
                                                          .currentUser!.uid,
                                                      isImage: false,
                                                      isAudio: false,
                                                      isVideo: false,
                                                    ).toJson())
                                                    .then((value) =>
                                                        refreshChat());

                                                await firestore
                                                    .collection("GroupChat")
                                                    .doc(value.id)
                                                    .update(
                                                        {"docId": value.id});

                                                controller.fcmName = arguments
                                                    .recieverName
                                                    .toString();
                                                controller.fcmProfileImage =
                                                    arguments.groupProfileImage
                                                        .toString();
                                                controller.fcmRecieverId =
                                                    arguments.recieverUid
                                                        .toString();
                                                controller.fcmDocId =
                                                    arguments.docId.toString();
                                                controller.update();

                                                PushNotify().postNotification(
                                                    token: arguments.fcmToken
                                                        .toString(),
                                                    title: userModel.name
                                                        .toString(),
                                                    subTitle: controller
                                                        .groupChatController
                                                        .text);
                                                controller.groupChatController
                                                    .clear();
                                                controller.update();
                                              });
                                            }
                                          }
                                        }
                                      },
                                      child: Material(
                                        elevation: 10,
                                        color: ColorConstants.cFFFFFF,
                                        borderRadius: BorderRadius.circular(20),
                                        shadowColor: ColorConstants.cFFFFFF,
                                        child: const Image(
                                          image: AssetImage(Assets.imagesDm),
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.fill,
                                          color: ColorConstants.c1F61E8,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        });
  }

  _appBar({required BuildContext context}) {
    return Material(
      elevation: 10,
      shadowColor: ColorConstants.c1F61E8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 40, bottom: 15),
        decoration: const BoxDecoration(
          color: ColorConstants.c1F61E8,
        ),
        child: Row(
          children: [
            backButton(context: context),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () async {
                var collection = FireBaseConstants.fireStore
                    .collection('GroupChat')
                    .doc(arguments.docId);

                DocumentSnapshot documentSnapShot = await collection.get();
                LastChatGroup lastGroupChat = LastChatGroup.fromJson(
                    documentSnapShot.data() as Map<String, dynamic>);

                Get.toNamed(groupProfileScreen,
                    arguments: GroupProfileArguments(
                        groupProfileImage: arguments.groupProfileImage,
                        groupName: arguments.groupName,
                        recieverUid: arguments.recieverUid,
                        groupCreatedBy: lastGroupChat.groupCreatedBy));
              },
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.cFFFFFF.withOpacity(0.1),
                        image: DecorationImage(
                            image: NetworkImage(
                                arguments.groupProfileImage.toString()),
                            fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arguments.groupName.toString(),
                        style: TextStyleDecoration.s12w500cFFFFFF,
                      ),
                      space05(),
                      Text(StringConstants.kJustNow,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.cFFFFFF.withOpacity(0.5))),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 0.22.sw,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorConstants.cFFFFFF.withOpacity(0.2),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {},
                      child: Image.asset(
                        Assets.imagesChatCall,
                        height: 16,
                        width: 16,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const VerticalDivider(
                      color: ColorConstants.cFFFFFF,
                      width: 1,
                    ),
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {},
                      child: Image.asset(
                        Assets.imagesVideoCallIcon,
                        height: 14,
                        width: 19,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      {required String title,
      required Color imageColor,
      required Color textColor,
      required String image,
      required VoidCallback onTap}) {
    return PopupMenuItem(
      // padding: EdgeInsets.zero,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: Row(
          children: [
            Image(
              image: AssetImage(image),
              height: 12,
              width: 12,
              color: imageColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  _receiverShowDialog() {
    return;
  }

  refreshChat() {
    try {
      Timer(
          const Duration(microseconds: 500),
          () => controller.scroll.animateTo(
                controller.scroll.position.maxScrollExtent,
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInToLinear,
              ));
    } catch (e) {
      print(e);
    }
  }
}
