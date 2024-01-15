import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/setting/controller/setting_screen_controller.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AlertTones extends StatelessWidget {
  AlertTones({Key? key}) : super(key: key);
  var controller = Get.isRegistered<SettingController>()
      ? Get.find<SettingController>()
      : Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          ///-----upper heading---------///
          Container(
            height: 0.16.sh,
            width: 1.sw,
            color: ColorConstants.c1F61E8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(context: context),
                  Text(
                    StringConstants.kSound,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    "Done",
                    style: TextStyle(
                      color: ColorConstants.cFFFFFF,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 0.130.sh,bottom: 0.04.sh),
            child: Material(
              elevation: 10,
              borderRadius:  BorderRadius.circular(15),
              color: Colors.transparent,
              shadowColor: ColorConstants.c626B84.withOpacity(0.5),
              child: Container(
                height: 1.sh,
                width: 1.sw,
                padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                   ),
                ///----screen ui
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringConstants.kAlertTones,
                      style: TextStyle(
                          color: ColorConstants.c1C2439,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    space10(),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: NoGlowHelper(),
                        child: ListView.separated(
                            itemCount: 25,
                            padding: const EdgeInsets.only(bottom: 30),
                            separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Logistical",
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
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }

// soundType() {
//   return Container(
//     height: 100,
//     width: 100,
//     color: Colors.green,
//   );
// }
}
