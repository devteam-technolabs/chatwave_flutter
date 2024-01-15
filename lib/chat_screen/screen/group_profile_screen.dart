import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/chat_screen/controller/chat_screen_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/arguments_model.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupProfileScreen extends StatelessWidget {
  GroupProfileScreen({super.key});

  var controller = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController());

  GroupProfileArguments arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.cECF4FF,
      body: Stack(
        children: [
          Image(
            image: const AssetImage(Assets.imagesProfileBack),
            width: double.infinity,
            height: 0.502.sh,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                space40(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    backButton(context: context),
                    const Text(
                      StringConstants.kGroupDetails,
                      style: TextStyleDecoration.s18w600cFFFFFF,
                    ),
                    const Image(
                      image: AssetImage(Assets.imagesEditContainerIcon),
                      width: 34,
                      height: 34,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                space10(),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoGlowHelper(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          space10(),
                          Container(
                            height: 0.12.sh,
                            width: 0.25.sw,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      arguments.groupProfileImage.toString()),
                                  fit: BoxFit.fill,
                                ),
                                color: Colors.transparent),
                          ),
                          Text(
                            arguments.groupName.toString(),
                            style: TextStyleDecoration.s20w600cFFFFFF,
                          ),
                          space05(),
                          Text(
                            "${arguments.recieverUid?.length} Members",
                            style: TextStyleDecoration.s12w400c8FB0F4,
                          ),
                          space10(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _callContainer(
                                  title: StringConstants.kCall,
                                  image: Assets.imagesChatCall,
                                  imageHeight: 15,
                                  imageWidth: 15),
                              const SizedBox(
                                width: 10,
                              ),
                              _callContainer(
                                  title: StringConstants.kVideo,
                                  image: Assets.imagesVideoCallIcon,
                                  imageHeight: 16,
                                  imageWidth: 22),
                            ],
                          ),
                          space30(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    "${StringConstants.kGroupCreated}${arguments.groupCreatedBy}",
                                    style: TextStyleDecoration.s12w500cFFFFFF,
                                  ),
                                  space05(),
                                  Text("Created on 12 Jul, 2023",
                                      style: TextStyle(
                                          color: ColorConstants.cFFFFFF
                                              .withOpacity(0.5),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ],
                          ),
                          space30(),


                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(15),
                            color: ColorConstants.cFFFFFF,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  space20(),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringConstants.kGroupMembers,
                                        style: TextStyle(
                                          color: ColorConstants.c1C2439,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      space15(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color:
                                                      ColorConstants.cE9EFFD),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    Assets.imagesAddIcon,
                                                    height: 9,
                                                    width: 9,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    StringConstants
                                                        .kNewMember,
                                                    style: TextStyleDecoration
                                                        .s12w400c1F61E8,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color:
                                                      ColorConstants.cE9EFFD),
                                              child: const Text(
                                                StringConstants.kInviteViaLink,
                                                style: TextStyleDecoration
                                                    .s12w400c1F61E8,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  space10(),
                                  ScrollConfiguration(
                                    behavior: NoGlowHelper(),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero.copyWith(bottom: 30),
                                      itemCount: arguments.recieverUid!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        print("${arguments.recieverUid!.length}lllllllllllllllllllllllllll");
                                        return StreamBuilder(
                                            stream: FireBaseConstants.fireStore.collection("User").where('uid', isEqualTo:arguments.recieverUid?[index]).snapshots(),
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData) {
                                                var querySnapshot = snapshot.data;
                                                UserModel userModel = UserModel.fromJson(querySnapshot!.docs[0].data());
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(8),
                                                          image:
                                                          DecorationImage(
                                                            image: NetworkImage(
                                                                userModel
                                                                    .profileImageUrl
                                                                    .toString()),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            userModel.name
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                ColorConstants
                                                                    .c1C2439,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize:
                                                                12.sp),
                                                          ),
                                                          space05(),
                                                          Text(
                                                            userModel.aboutMe.toString(),
                                                            style: TextStyle(
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              color:
                                                              ColorConstants
                                                                  .c626B84,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              fontSize: 10.sp,
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      arguments.groupCreatedBy == userModel.name
                                                          ? const Text(
                                                        StringConstants
                                                            .kAdmin,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w400,
                                                            fontSize: 10,
                                                            color: ColorConstants
                                                                .cA5C0F6),
                                                      )
                                                          : const Text(""),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                        splashFactory: NoSplash.splashFactory,
                                                        onTap: (){
                                                          if(userModel.uid != FireBaseConstants.auth.currentUser!.uid){
                                                            Get.toNamed(userProfileScreen,
                                                                arguments: ChatArgumnets(
                                                                    recieverId: userModel.uid,
                                                                    profileImage: userModel.profileImageUrl,
                                                                    recieverName: userModel.name,
                                                                    docId: ""));
                                                          }
                                                        },
                                                        child: Image.asset(
                                                          Assets
                                                              .imagesForwardIcon,
                                                          height: 13,
                                                          width: 8,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }else{
                                                return const Center(
                                                  child: CircularProgressIndicator(
                                                    color: ColorConstants.cFFFFFF,
                                                  ),
                                                );
                                              }
                                            }
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context,
                                          int index) {
                                        return const Divider();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          space30(),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(15),
                            color: ColorConstants.cFFFFFF,
                            shadowColor: ColorConstants.cFFFFFF,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      StringConstants.kClearChat,
                                      style: TextStyleDecoration.s14w500cE21A27,
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      StringConstants.kExitGroup,
                                      style: TextStyleDecoration.s14w500cE21A27,
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 7),
                                    child: Text(
                                      StringConstants.kReportGroup,
                                      style: TextStyleDecoration.s14w500c1C2439,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          space30(),
                          space30(),
                          space30(),
                          space30(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _addContainer() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorConstants.cE9EFFD),
        child: const Text(
          StringConstants.kInviteViaLink,
          style: TextStyleDecoration.s12w400c1F61E8,
        ),
      ),
    );
  }

  _callContainer(
      {required String title,
      required String image,
      required double imageHeight,
      required double imageWidth}) {
    return Container(
      height: 40,
      width: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.cFFFFFF.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(image),
            height: imageHeight,
            width: imageWidth,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyleDecoration.s12w500cFFFFFF,
          ),
        ],
      ),
    );
  }
}
