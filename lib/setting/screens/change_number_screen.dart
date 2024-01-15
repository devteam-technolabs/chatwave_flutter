import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/setting/controller/setting_screen_controller.dart';
import 'package:chatwave_flutter/utils/custom_textfields.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ChangeNumberScreen extends StatelessWidget {
  ChangeNumberScreen({super.key});

  var controller = Get.isRegistered<SettingController>()
      ? Get.find<SettingController>()
      : Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SettingController>(
        init: SettingController(),
        builder: (value) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 1.sw,
              color: ColorConstants.c1F61E8,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(context: context),
                  Text(
                    StringConstants.kChangeMyNumber,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    width: 0.1.sw,
                  ),
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
                    StringConstants.kOldNumber,
                    style: TextStyle(
                        color: ColorConstants.c1C2439,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  space15(),
                  CustomTextFieldCountryOld(
                      label: StringConstants.kCountryRegion,
                      icon: Assets.imagesCountryFlagIcon,
                      hint: 'Select',
                      filledColor: ColorConstants.cECF4FF,
                      controller: controller),
                  ///-----validations for the country
                  controller.selectCountryErrorOld.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      controller.selectCountryErrorOld,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  )
                      : Container(),
                  space20(),
                  CustomTextFieldNumber(
                    textEditController: controller.phoneNumberControllerOld,
                    filled: true,
                    // focusNode: FocusNode(),
                    icon: Assets.imagesPhoneNumberIcon,
                    textInputType: TextInputType.phone,
                    label: StringConstants.kPhoneNumber,
                    onChanged: (String) {
                      // controller.phoneNumberErrorOld = "";
                      controller.update();
                    },
                    hintExist: true,
                    hint: StringConstants.kEnterYourNumber,
                    filledColor: ColorConstants.cECF4FF,
                  ),
                  space10(),
                  controller.phoneNumberErrorOld.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5, top: 5),
                          child: Text(
                            controller.phoneNumberErrorOld,
                            style:
                                TextStyle(color: Colors.red, fontSize: 12.sp),
                          ),
                        )
                      : Container(),
                  space30(),
                  Text(
                    StringConstants.kNewNumber,
                    style: TextStyle(
                        color: ColorConstants.c1C2439,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  space15(),
                  CustomTextFieldCountryNew(
                      label: StringConstants.kCountryRegion,
                      icon: Assets.imagesCountryFlagIcon,
                      hint: 'Select',
                      filledColor: ColorConstants.cECF4FF,
                      controller: controller),
                  ///-----validations for the country
                  controller.selectCountryErrorNew.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      controller.selectCountryErrorNew,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  )
                      : Container(),
                  space20(),
                  CustomTextFieldNumber(
                    textEditController: controller.phoneNumberControllerNew,
                    filled: true,
                    // focusNode: FocusNode(),
                    icon: Assets.imagesPhoneNumberIcon,
                    textInputType: TextInputType.phone,
                    label: StringConstants.kPhoneNumber,
                    onChanged: (String) {
                      //controller.phoneNumberErrorNew = "";
                      controller.update();
                    },
                    hintExist: true,
                    hint: StringConstants.kEnterYourNumber,
                    filledColor: ColorConstants.cECF4FF,
                  ),

                  ///-----validations for the phone number
                  space10(),
                  controller.phoneNumberErrorNew.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5, top: 5),
                          child: Text(
                            controller.phoneNumberErrorNew,
                            style:
                                TextStyle(color: Colors.red, fontSize: 12.sp),
                          ),
                        )
                      : Container(),

                  space40(),
                  Center(
                      child: commonButton(
                          title: StringConstants.kSave,
                          onTap: () async {
                            await controller.validationPhoneNumberOld();
                          }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFieldCountryOld extends StatelessWidget {
  String? icon;
  String label;
  Color? filledColor;
  String? hint;
  SettingController controller;

  CustomTextFieldCountryOld({
    Key? key,
    this.icon,
    required this.label,
    this.filledColor,
    this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          countryListTheme: CountryListThemeData(
            flagSize: 25,
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            bottomSheetHeight: 400,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Start typing to search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                ),
              ),
            ),
          ),
          onSelect: (Country country) {
            controller.countryNameOld = country.name;
            controller.countryCodeOld = country.phoneCode;
            controller.selectCountryOld=false;
            controller.selectCountryErrorOld="";
            controller.update();
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorConstants.cECF4FF,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Image.asset(
                icon.toString(),
                height: 22,
                width: 18,
                fit: BoxFit.fill,
                color: ColorConstants.c1F61E8,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        color: ColorConstants.c626B84,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  space15(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectCountryOld==true?"Select":"(+${controller.countryCodeOld}) ${controller.countryNameOld}",
                        style: const TextStyle(
                            color: ColorConstants.c1C2439,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const Image(
                        image: AssetImage(Assets.imagesDropdownIcon),
                        height: 6,
                        width: 11,
                        color: ColorConstants.c202020,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFieldCountryNew extends StatelessWidget {
  String? icon;
  String label;
  Color? filledColor;
  String? hint;
  SettingController controller;

  CustomTextFieldCountryNew({
    Key? key,
    this.icon,
    required this.label,
    this.filledColor,
    this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          countryListTheme: CountryListThemeData(
            flagSize: 25,
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            bottomSheetHeight: 400,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Start typing to search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                ),
              ),
            ),
          ),
          onSelect: (Country country) {
            controller.countryNameNew = country.name;
            controller.countryCodeNew = country.phoneCode;
            controller.selectCountryNew=false;
            controller.selectCountryErrorNew="";
            controller.update();
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorConstants.cECF4FF,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Image.asset(
                icon.toString(),
                height: 22,
                width: 18,
                fit: BoxFit.fill,
                color: ColorConstants.c1F61E8,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        color: ColorConstants.c626B84,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  space15(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectCountryNew==true?"Select":"(+${controller.countryCodeNew}) ${controller.countryNameNew}",
                        style: const TextStyle(
                            color: ColorConstants.c1C2439,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const Image(
                        image: AssetImage(Assets.imagesDropdownIcon),
                        height: 6,
                        width: 11,
                        color: ColorConstants.c202020,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
