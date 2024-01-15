import 'package:chatwave_flutter/chat_screen/controller/chat_screen_controller.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EncryptionScreen extends StatelessWidget {
  EncryptionScreen({super.key});

  var controller = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.cECF4FF,
      body: Stack(
        children: [
          const Image(
            image: AssetImage(Assets.imagesProfileBack),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      backButton(context: context),
                      const Text(
                        StringConstants.kEncryption,
                        style: TextStyleDecoration.s18w600cFFFFFF,
                      ),
                      const Image(
                        image: AssetImage(Assets.imagesEncryptImageScreen),
                        width: 34,
                        height: 34,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: ColorConstants.cFFFFFF.withOpacity(0.3),
                            width: 4),
                      ),
                      child: const Image(
                        image: AssetImage(Assets.imagesQrCode),
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    space20(),
                    const Text(
                      StringConstants.kEncryptionDescription,
                      style: TextStyle(
                        height: 1.5,
                        color: ColorConstants.c8FB0F4,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(
                  height: 0.2.sh,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
