import 'dart:developer';

import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/calls_screen/controller/call_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/arguments_model.dart';
import 'package:chatwave_flutter/chat_screen/model/lastChat_model.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/key_constants.dart';

class CallsDashboardScreen extends StatelessWidget {
  CallsDashboardScreen({super.key});

  var controller = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.cECF4FF,
      body: GetBuilder<CallController>(
        init: CallController(),
        builder: (value) => Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              height: 0.25.sh,
              width: double.infinity,
              decoration: const BoxDecoration(color: ColorConstants.c1F61E8),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    StringConstants.kCalls,
                    style: TextStyleDecoration.s26w600cFFFFFF,
                  ),
                  space40(),
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      Get.toNamed(newCallScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 23),
                      decoration: BoxDecoration(
                        color: ColorConstants.c3571EA,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(Assets.imagesPlusIcon),
                            height: 9,
                            width: 9,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            StringConstants.kNewCall,
                            style: TextStyleDecoration.s14w400cFFFFFF,
                          )
                        ],
                      ),
                    ),
                  ),
                  space20(),
                  callRecords(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  callRecords() {
    return ScrollConfiguration(
      behavior: NoGlowHelper(),
      child: SingleChildScrollView(
        child: StreamBuilder(
            stream: FireBaseConstants.fireStore.collection("Chat").where("uid",
                arrayContainsAny: [
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
                      return element == FireBaseConstants.auth.currentUser!.uid;
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
                              splashFactory: NoSplash.splashFactory,
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
                                  lastChatList.add(LastChat.fromJson(u.data()));
                                }

                                int search = lastChatList.indexWhere((element) {
                                  return element.uid!.contains(userModel.uid);
                                });
                                log("found ${search}");

                                if (search != -1) {
                                  log("found ${response1.docs[search].id}");
                                  Get.toNamed(chatMessagingScreen,
                                      arguments: ChatArgumnets(
                                        docId: response1.docs[search].id,
                                        recieverId: userModel.uid.toString(),
                                        profileImage: userModel.profileImageUrl
                                            .toString(),
                                        recieverName: userModel.name.toString(),
                                        isCreated: true,
                                      ));
                                } else {
                                  Get.toNamed(chatMessagingScreen,
                                      arguments: ChatArgumnets(
                                        recieverId: userModel.uid.toString(),
                                        profileImage: userModel.profileImageUrl
                                            .toString(),
                                        recieverName: userModel.name.toString(),
                                        isCreated: false,
                                      ));
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Material(
                                  elevation: 3,
                                  shadowColor: ColorConstants.cFFFFFF,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
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
                                                  image: NetworkImage(userModel
                                                      .profileImageUrl
                                                      .toString()))),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userModel.name.toString(),
                                                style: TextStyleDecoration
                                                    .s12w500c1C2439,
                                              ),
                                              space05(),
                                              const Text(
                                                StringConstants.kJustNow,
                                                style: TextStyleDecoration
                                                    .s10w400c626B84,
                                              ),
                                              space10(),
                                              index == 0
                                                  ? const Text(
                                                      StringConstants.kIncoming,
                                                      style: TextStyleDecoration
                                                          .s10w400c1C2439,
                                                    )
                                                  : index == 1
                                                      ? const Text(
                                                          StringConstants
                                                              .kOutgoing,
                                                          style:
                                                              TextStyleDecoration
                                                                  .s10w400c1F61E8,
                                                        )
                                                      : const Text(
                                                          StringConstants
                                                              .kMissed,
                                                          style:
                                                              TextStyleDecoration
                                                                  .s10w400cE21A27,
                                                        ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            index % 2 == 0
                                                ? const Image(
                                                    image: AssetImage(Assets
                                                        .imagesVideoIconCallScreen),
                                                    height: 15,
                                                    width: 20,
                                                    color:
                                                        ColorConstants.cE9E9E9,
                                                    fit: BoxFit.fill,
                                                  )
                                                : const Image(
                                                    image: AssetImage(Assets
                                                        .imagesCallIconCallScreen),
                                                    height: 19,
                                                    width: 19,
                                                    color:
                                                        ColorConstants.cE9E9E9,
                                                    fit: BoxFit.fill,
                                                  ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Image(
                                              image: AssetImage(Assets
                                                  .imagesArrowIconCallScreen),
                                              height: 13,
                                              width: 7,
                                              color: ColorConstants.cE9E9E9,
                                              fit: BoxFit.fill,
                                            ),
                                          ],
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
    );
  }
}
