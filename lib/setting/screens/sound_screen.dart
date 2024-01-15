import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/setting/controller/setting_screen_controller.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SoundScreen extends StatelessWidget {
  SoundScreen({Key? key}) : super(key: key);
  var controller = Get.isRegistered<SettingController>()
      ? Get.find<SettingController>()
      : Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (value) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 1.sw,
              color: ColorConstants.c1F61E8,
              padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(context: context),
                  Text(
                    StringConstants.kSound,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                    ),
                  ),
                  const Text(""),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space15(),
                  Text(
                    StringConstants.kMessageNotification,
                    style: TextStyle(
                        color: ColorConstants.c1C2439,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  space15(),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  StringConstants.kShowNotifications,
                                  style: TextStyle(
                                    color: ColorConstants.c1C2439,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
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
                                    inactiveTrackColor: ColorConstants.cE9E9E9,
                                    value: controller.isSelected,
                                    onChanged: (value) {
                                      controller.isSelected = value;
                                      controller.update();
                                    }),
                              ],
                            ),
                            Divider(
                              color: ColorConstants.c626B84.withOpacity(0.1),
                              thickness: 1,
                            ),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                               Get.toNamed(alertTones);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          StringConstants.kElecto,
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
                                Get.toNamed(soundTypeScreen);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      StringConstants.kSoundType,
                                      style: TextStyle(
                                        color: ColorConstants.c1C2439,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          StringConstants.kSoundAndVibration,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  space15(),
                  Text(
                    StringConstants.kGroupNotification,
                    style: TextStyle(
                        color: ColorConstants.c1C2439,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  space10(),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  StringConstants.kShowNotifications,
                                  style: TextStyle(
                                    color: ColorConstants.c1C2439,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
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
                                    inactiveTrackColor: ColorConstants.cE9E9E9,
                                    value: controller.isSelected,
                                    onChanged: (value) {
                                      controller.isSelected = value;
                                      controller.update();
                                    }),
                              ],
                            ),
                            Divider(
                              color: ColorConstants.c626B84.withOpacity(0.1),
                              thickness: 1,
                            ),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                Get.toNamed(alertTones);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          StringConstants.kElecto,
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
                                Get.toNamed(soundTypeScreen);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      StringConstants.kSoundType,
                                      style: TextStyle(
                                        color: ColorConstants.c1C2439,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          StringConstants.kSoundAndVibration,
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
      ),
    );
  }
}
