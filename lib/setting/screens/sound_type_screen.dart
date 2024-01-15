import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/setting/controller/setting_screen_controller.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SoundTypeScreen extends StatelessWidget {
  SoundTypeScreen({Key? key}) : super(key: key);
  var controller = Get.isRegistered<SettingController>()
      ? Get.find<SettingController>()
      : Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          ///-----upper heading---------///
          Container(
            height: 125,
            width: 1.sw,
            color: ColorConstants.c1F61E8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(context: context),
                  Text(
                    StringConstants.kSoundType,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    width: 0.1.sw,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 0.118.sh),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent,
              shadowColor: ColorConstants.cFFFFFF,
              child: Container(
                //margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 0.118.sh),
                padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 1),
                        blurRadius: 0.1,
                        spreadRadius: 0.1,
                      ), //BoxShadow
                    ]),
                ///----screen ui
                child: ScrollConfiguration(
                  behavior: NoGlowHelper(),
                  child: ListView.separated(
                    shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.soundType.length,
                      padding: const EdgeInsets.only(bottom: 10),
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                           // Get.toNamed(soundScreen);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.soundType[index],
                                      style: TextStyle(
                                          color: ColorConstants.c1C2439,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    index%3==0 ? Text(
                                      "Selected",
                                      style: TextStyle(
                                          color: ColorConstants.cD2D2D2,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400),
                                    ):Text(
                                      "",
                                      style: TextStyle(
                                          color: ColorConstants.cD2D2D2,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          )
        ]));
  }
}
