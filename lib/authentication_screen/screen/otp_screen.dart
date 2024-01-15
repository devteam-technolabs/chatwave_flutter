import 'package:chatwave_flutter/authentication_screen/controller/authentication_controller.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/utils/custom_textfields.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends GetView<AuthenticationController> {
  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AuthenticationController(),
        builder: (value) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  const Image(
                    image: AssetImage(Assets.imagesOtpScreenBackground),
                    height: 152,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 40),
                    child: backButton(context: context),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringConstants.kVerifyYourNumber,
                      style: TextStyleDecoration.s26w600c1C2439,
                    ),
                    space15(),
                    const Text(
                      StringConstants.kOtpScreenDescription,
                      style: TextStyleDecoration.s12w400c626B84,
                    ),
                    space30(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFieldPin(
                                  unFocusFirst: true,
                                  textEditController: controller.otp1,
                                  //focusNode: FocusNode(),
                                  onChanged: (String) {
                                    controller.update();
                                  },
                                ),
                              ),
                              _commonWidth15(),
                              Expanded(
                                child: CustomTextFieldPin(
                                  textEditController: controller.otp2,
                                  // focusNode: FocusNode(),
                                  onChanged: (String) {
                                    controller.update();
                                  },
                                ),
                              ),
                              _commonWidth15(),
                              Expanded(
                                child: CustomTextFieldPin(
                                  textEditController: controller.otp3,
                                  // focusNode: FocusNode(),
                                  onChanged: (String) {
                                    controller.update();
                                  },
                                ),
                              ),
                              _commonWidth15(),
                              Expanded(
                                child: CustomTextFieldPin(
                                  textEditController: controller.otp4,
                                  // focusNode: FocusNode(),
                                  onChanged: (value) {
                                    controller.update();
                                  },
                                ),
                              ),
                              _commonWidth15(),
                              Expanded(
                                child: CustomTextFieldPin(
                                  textEditController: controller.otp5,
                                  //focusNode: FocusNode(),
                                  onChanged: (value) {
                                    controller.update();
                                  },
                                ),
                              ),
                              _commonWidth15(),
                              Expanded(
                                child: CustomTextFieldPin(
                                  unFocus: true,
                                  textEditController: controller.otp6,
                                  //focusNode: FocusNode(),
                                  onChanged: (value) {
                                    controller.update();
                                  },
                                ),
                              ),
                            ],
                          ),
                          space05(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.otpError.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 5),
                                      child: controller.start == 0
                                          ? Text(
                                              controller.otpError =
                                                  'Otp time is out please resend otp again',
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              controller.otpError,
                                              style:  TextStyle(
                                                  color: controller.otpValidColor == true ? Colors.green:Colors.red),
                                            ),
                                    )
                                  : Container(),
                              controller.start < 10
                                  ? Text(
                                      "00:0${controller.start} ",
                                      style: TextStyleDecoration.s12w500c1F61E8,
                                    )
                                  : Text(
                                      "00:${controller.start} ",
                                      style: TextStyleDecoration.s12w500c1F61E8,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    space20(),
                    Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                              ),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                    text:
                                        StringConstants.kDidNotReceivedTheCode,
                                    style: TextStyleDecoration.s12w500c626B84),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.resendOtp();
                                      },
                                    text: StringConstants.kResend,
                                    style: TextStyleDecoration.s12w500c1C2439),
                              ])),
                    ),
                    space40(),
                    Center(
                        child: commonButton(
                            title: StringConstants.kVerify,
                            onTap: () {
                              controller.validationOtp();
                            }))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _commonWidth15() {
    return const SizedBox(
      width: 10,
    );
  }
}
