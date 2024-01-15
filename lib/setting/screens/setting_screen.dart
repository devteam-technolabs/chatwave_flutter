import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/firebase_services/services/firebase_services.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/setting/controller/setting_screen_controller.dart';
import 'package:chatwave_flutter/setting/model/privacy_and_security_model.dart';
import 'package:chatwave_flutter/setting/screens/web_view_screen.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  var controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///-------appbar using row and container
          Container(
            height: 100,
            width: 1.sw,
            color: ColorConstants.c1F61E8,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringConstants.kSettings,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                    ),
                  ),
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      FirebaseServices().signOut();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.imagesLogoutIcon,
                          height: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          StringConstants.kLogout,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          ///------bottom screen details
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowHelper(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space15(),

                      ///---general section
                      Text(
                        StringConstants.kGeneral,
                        style: TextStyle(
                            color: ColorConstants.c1C2439,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      space15(),
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(15),
                        shadowColor: Colors.black,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorConstants.cFFFFFF,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      StringConstants.kNotifications,
                                      style: TextStyle(
                                        color: ColorConstants.c1C2439,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Switch(
                                        activeTrackColor:
                                            ColorConstants.c1F61E8,
                                        inactiveThumbColor: Colors.transparent,
                                        activeThumbImage: const AssetImage(
                                          'assets/images/active_switch_thumb.png',
                                        ),
                                        inactiveThumbImage: const AssetImage(
                                          'assets/images/switch_handle.png',
                                        ),
                                        activeColor: Colors.white,
                                        inactiveTrackColor:
                                            ColorConstants.cE9E9E9,
                                        value: controller.isSelected,
                                        onChanged: (value) {
                                          controller.isSelected = value;
                                          controller.update();
                                        }),
                                  ],
                                ),
                                Divider(
                                  color:
                                      ColorConstants.c626B84.withOpacity(0.1),
                                  thickness: 1,
                                ),
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  onTap: () {
                                    Get.toNamed(soundScreen);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 7),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          StringConstants.kSound,
                                          style: TextStyle(
                                            color: ColorConstants.c1C2439,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringConstants.kChange,
                                              style: TextStyle(
                                                color: ColorConstants.cD2D2D2,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              color: ColorConstants.cE9E9E9,
                                              size: 15,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color:
                                      ColorConstants.c626B84.withOpacity(0.1),
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Light Mode ',
                                        style: TextStyle(
                                          color: ColorConstants.c1C2439,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' Theme',
                                            style: TextStyle(
                                              color: ColorConstants.cD2D2D2,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Switch(
                                        activeTrackColor:
                                            ColorConstants.c1F61E8,
                                        inactiveThumbColor: Colors.transparent,
                                        activeThumbImage: const AssetImage(
                                          'assets/images/active_switch_thumb.png',
                                        ),
                                        inactiveThumbImage: const AssetImage(
                                          'assets/images/switch_handle.png',
                                        ),
                                        activeColor: Colors.white,
                                        inactiveTrackColor:
                                            ColorConstants.cE9E9E9,
                                        value: controller.isSelected,
                                        onChanged: (value) {
                                          controller.isSelected = value;
                                          controller.update();
                                        }),
                                  ],
                                ),
                                space10(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      space15(),
                      Text(
                        StringConstants.kPrivacySecurity,
                        style: TextStyle(
                            color: ColorConstants.c1C2439,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      space10(),

                      ///-----Privacy and security
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(15),
                        shadowColor: Colors.black,
                        color: ColorConstants.cFFFFFF,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              space20(),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  Get.toNamed(privacyAndSecurityScreen,
                                      arguments: PrivacyModel(
                                          title: StringConstants.kLastSeen,
                                          subTitle: StringConstants
                                              .kWhoWillSeeYourLastSeen));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        StringConstants.kLastSeen,
                                        style: TextStyle(
                                          color: ColorConstants.c1C2439,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            StringConstants.kEveryOne,
                                            style: TextStyle(
                                              color: ColorConstants.cD2D2D2,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: ColorConstants.cE9E9E9,
                                            size: 15,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: ColorConstants.c626B84.withOpacity(0.1),
                                thickness: 1,
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  Get.toNamed(privacyAndSecurityScreen,
                                      arguments: PrivacyModel(
                                          title: StringConstants.kProfileImage,
                                          subTitle: StringConstants
                                              .kWhoWillSeeYourProfileImage));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        StringConstants.kProfileImage,
                                        style: TextStyle(
                                          color: ColorConstants.c1C2439,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            StringConstants.kMyContacts,
                                            style: TextStyle(
                                              color: ColorConstants.cD2D2D2,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: ColorConstants.cE9E9E9,
                                            size: 15,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: ColorConstants.c626B84.withOpacity(0.1),
                                thickness: 1,
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  Get.toNamed(privacyAndSecurityScreen,
                                      arguments: PrivacyModel(
                                          title: StringConstants.kStatus,
                                          subTitle: StringConstants
                                              .kWhoWillSeeYourStatus));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          StringConstants.kStatus,
                                          style: TextStyle(
                                            color: ColorConstants.c1C2439,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringConstants.kNobody,
                                              style: TextStyle(
                                                color: ColorConstants.cD2D2D2,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              color: ColorConstants.cE9E9E9,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                              Divider(
                                color: ColorConstants.c626B84.withOpacity(0.1),
                                thickness: 1,
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  Get.toNamed(privacyAndSecurityScreen,
                                      arguments: PrivacyModel(
                                          title: StringConstants.kStory,
                                          subTitle: StringConstants
                                              .kWhoWillSeeYourStory));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          StringConstants.kStory,
                                          style: TextStyle(
                                            color: ColorConstants.c1C2439,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringConstants.kNobody,
                                              style: TextStyle(
                                                color: ColorConstants.cD2D2D2,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              color: ColorConstants.cE9E9E9,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                              Divider(
                                color: ColorConstants.c626B84.withOpacity(0.1),
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Read Recipient ',
                                      style: TextStyle(
                                        color: ColorConstants.c1C2439,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Switch(
                                      activeTrackColor: ColorConstants.c1F61E8,
                                      inactiveThumbColor: Colors.transparent,
                                      activeThumbImage: const AssetImage(
                                        'assets/images/active_switch_thumb.png',
                                      ),
                                      inactiveThumbImage: const AssetImage(
                                        'assets/images/switch_handle.png',
                                      ),
                                      activeColor: Colors.white,
                                      inactiveTrackColor:
                                          ColorConstants.cE9E9E9,
                                      value: controller.isSelected,
                                      onChanged: (value) {
                                        controller.isSelected = value;
                                        controller.update();
                                      }),
                                ],
                              ),
                              space05(),
                            ],
                          ),
                        ),
                      ),
                      space15(),
                      Text(
                        StringConstants.kOther,
                        style: TextStyle(
                            color: ColorConstants.c1C2439,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      space10(),

                      ///-----other section
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(15),
                        shadowColor: Colors.black,
                        color: ColorConstants.cFFFFFF,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              space30(),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  Get.toNamed(changeNumberScreen);
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          StringConstants.kChangeMyNumber,
                                          style: TextStyle(
                                            color: ColorConstants.c1C2439,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: ColorConstants.cE9E9E9,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                    space10(),
                                  ],
                                ),
                              ),
                              Divider(
                                color: ColorConstants.c626B84.withOpacity(0.1),
                                thickness: 1,
                              ),
                              GestureDetector(

                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return deleteShowDialog();
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        StringConstants.kDeleteAccount,
                                        style: TextStyle(
                                          color: ColorConstants.c1C2439,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: ColorConstants.cE9E9E9,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: ColorConstants.c626B84.withOpacity(0.1),
                                thickness: 1,
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewScreen(
                                          url:
                                          "https://feverdrop.itechnolabs.tech/api/privacy-policy",
                                          name:StringConstants.kPrivacyPolicy,),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        StringConstants.kPrivacyPolicy,
                                        style: TextStyle(
                                          color: ColorConstants.c1C2439,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: ColorConstants.cE9E9E9,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: ColorConstants.c626B84.withOpacity(0.1),
                                thickness: 1,
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewScreen(
                                            url:
                                            "https://feverdrop.itechnolabs.tech/api/privacy-policy",
                                            name:StringConstants.kTermsConditions,),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          StringConstants.kTermsConditions,
                                          style: TextStyle(
                                            color: ColorConstants.c1C2439,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: ColorConstants.cE9E9E9,
                                          size: 15,
                                        ),
                                      ]),
                                ),
                              ),
                              Divider(
                                color: ColorConstants.c626B84.withOpacity(0.1),
                                thickness: 1,
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewScreen(
                                            url:
                                            "https://feverdrop.itechnolabs.tech/api/privacy-policy",
                                            name:StringConstants.kAboutUs,),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          StringConstants.kAboutUs,
                                          style: TextStyle(
                                            color: ColorConstants.c1C2439,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: ColorConstants.cE9E9E9,
                                          size: 15,
                                        ),
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
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
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                  },
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
