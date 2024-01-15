import 'package:chatwave_flutter/authentication_screen/controller/authentication_controller.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/utils/custom_textfields.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:chatwave_flutter/utils/no_glow_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    super.key,
  });

  var controller = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.cFFFFFF,
      body: GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        builder: (value) => ModalProgressHUD(
          inAsyncCall: controller.shimmerEffectLogin,
          opacity: 0.5,
          color: Colors.blue,
          progressIndicator: const CircularProgressIndicator(
            color: Colors.blue,
          ),
          dismissible: false,
          blur: 0.2,
          child: ScrollConfiguration(
            behavior: NoGlowHelper(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height: 1.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage(Assets.imagesLoginBackground),
                          height: 375,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        space10(),
                        _loginView(context: context),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          StringConstants.kV10AllRightsReserved,
                          style: TextStyleDecoration.s10w400cD2D2D2,
                        ),
                        space10()
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginView({required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                StringConstants.kLoginDescription,
                style: TextStyleDecoration.s26w600c1C2439,
              ),
              space30(),
              CustomTextFieldCountry(
                  label: StringConstants.kCountryRegion,
                  icon: Assets.imagesCountryFlagIcon,
                  hint: 'Select',
                  filledColor: ColorConstants.cECF4FF,
                  controller: controller),

              ///-----validations for the country
              controller.selectCountryError.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        controller.selectCountryError,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    )
                  : Container(),
              space20(),
              CustomTextFieldNumber(
                textEditController: controller.phoneNumberController,
                filled: true,
                //focusNode: FocusNode(),
                icon: Assets.imagesPhoneNumberIcon,
                textInputType: TextInputType.phone,
                label: StringConstants.kPhoneNumber,
                onChanged: (String) {
                  controller.phoneNumberError = "";
                  controller.update();
                },
                hintExist: true,
                hint: StringConstants.kEnterYourNumber,
                filledColor: ColorConstants.cECF4FF,
              ),

              ///-----validations for the phone number
              controller.phoneNumberError.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        controller.phoneNumberError,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    )
                  : Container(),

              space40(),

              Center(
                  child: commonButton(
                      title: StringConstants.kNext,
                      onTap: () async {
                        await controller.validationPhoneNumber();
                      },
                      buttonColor: controller.phoneNumberController.text.isEmpty
                          ? ColorConstants.cE9E9E9
                          : ColorConstants.c1F61E8,
                      textColor: controller.phoneNumberController.text.isEmpty
                          ? ColorConstants.c202020
                          : ColorConstants.cFFFFFF)),
            ],
          ),
        ),
      ],
    );
  }
}
