import 'package:chatwave_flutter/authentication_screen/model/user_model.dart';
import 'package:chatwave_flutter/calls_screen/screens/calls_dashboard_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/chats_dashboard_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/group_profile_screen.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/custom_bottom_bar/controller/custom_bottom_bar_controller.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/profile_screen/screen/self_profile_screen.dart';
import 'package:chatwave_flutter/setting/screens/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/key_constants.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({super.key});

  var controller = Get.put(CustomBottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          buildPageView(),
          GetBuilder(
            init: controller,
            builder: (controller) => Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 55,
                ).copyWith(bottom: 25),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.c1C2439,
                  child: Container(
                    height: 60,
                    //margin: const EdgeInsets.symmetric(horizontal: 40,).copyWith(bottom: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorConstants.c1C2439,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25)
                          .copyWith(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _bottomIcon(
                              index: 0,
                              filledImage: Assets.imagesChatFilledIcon,
                              blankImage: Assets.imagesChatBottomIcon),
                          _bottomIcon(
                              index: 1,
                              filledImage: Assets.imagesCallFilledIcon,
                              blankImage: Assets.imagesCallBlankIcon),
                          _bottomIcon(
                              index: 2,
                              filledImage: Assets.imagesSettingFilledIcon,
                              blankImage: Assets.imagesSettingBlankIcon),
                          StreamBuilder(
                            stream: FireBaseConstants.fireStore.collection(KeyConstants.kUser).doc(FireBaseConstants.auth.currentUser!.uid).snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData) {
                                DocumentSnapshot documentSnapshot =
                                snapshot.data as DocumentSnapshot<Object?>;
                                UserModel userModel = UserModel.fromJson(
                                    documentSnapshot.data() as Map<String, dynamic>);
                                return GestureDetector(
                                  onTap: () {
                                    controller.bottomTapped(3);
                                    controller.pageController.animateToPage(
                                      3,
                                      duration: const Duration(
                                          milliseconds: 100),
                                      curve: Curves.bounceIn,
                                    );
                                    controller.update();
                                  },
                                  child:  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 17,
                                      backgroundImage:
                                      // AssetImage(Assets.imagesProfilepicman),
                                      NetworkImage(userModel.profileImageUrl.toString()),
                                    ),
                                  ),
                                );
                              }else{
                                return const Center(child: CircularProgressIndicator(color: Colors.transparent,),);
                              }
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _bottomIcon(
      {required int index,
      required String filledImage,
      required String blankImage}) {
    return InkWell(
      onTap: () {
        controller.bottomTapped(index);
        controller.pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        controller.update();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // controller.bottomSelectedIndex==index?
          if (controller.bottomSelectedIndex == index) ...[
            Column(
              children: [
                Image(
                  image: AssetImage(filledImage),
                  height: 30,
                  width: 30,
                  color: ColorConstants.cFFFFFF,
                  fit: BoxFit.fill,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: AnimatedContainer(
                      width: 20,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // Define how long the animation should take.
                      duration: const Duration(seconds: 1),
                      // Provide an optional curve to make the animation feel smoother.
                      curve: Curves.slowMiddle,
                    ))
              ],
            ),
          ],
          if (controller.bottomSelectedIndex != index) ...[
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image(
                image: AssetImage(blankImage),
                height: 20,
                width: 20,
                color: ColorConstants.c495061,
                fit: BoxFit.fill,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget buildPageView() {
    return PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        controller.pageChanged(index);
        controller.update();
      },
      children: <Widget>[
        ChatsDashBoardScreen(),
        CallsDashboardScreen(),
        SettingScreen(),
        SelfProfileScreen(),
      ],
    );
  }
}
