import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/setting/controller/setting_screen_controller.dart';
import 'package:chatwave_flutter/setting/model/contact_model.dart';
import 'package:chatwave_flutter/setting/model/privacy_and_security_model.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivacyAndSecurityScreen extends StatelessWidget {
  PrivacyAndSecurityScreen({Key? key}) : super(key: key);
  var controller = Get.isRegistered<SettingController>()
      ? Get.find<SettingController>()
      : Get.put(SettingController());

  PrivacyModel argument=Get.arguments;

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
                    argument.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                   SizedBox(width: 0.1.sw,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space20(),
                  Text(
                   argument.subTitle,
                    style: TextStyle(
                        color: ColorConstants.c1C2439,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  space15(),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(15),
                    color: ColorConstants.cFFFFFF,
                    child: ScrollConfiguration(
                      behavior: NoGlowHelper(),
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.privacySeen.length,
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                               if(index==3){
                                 RoutModel routeModel = RoutModel();
                                 routeModel.title = StringConstants.kMyContactsExcept;
                                 routeModel.contact ==true;
                                 Get.toNamed(myContactScreen,arguments: routeModel);
                               }
                               if (index==4){
                                 RoutModel routeModel = RoutModel();
                                 routeModel.title = StringConstants.kOnlyShareWith;
                                 routeModel.contact ==true;
                                 Get.toNamed(myContactScreen,arguments: routeModel);
                               }
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
                                          controller.privacySeen[index],
                                          style: TextStyle(
                                              color: ColorConstants.c1C2439,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        index == 3 ?  Text(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
