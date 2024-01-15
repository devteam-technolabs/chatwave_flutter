import 'package:chatwave_flutter/chat_screen/controller/chat_screen_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/arguments_model.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/constants/string_constants.dart';
import 'package:chatwave_flutter/constants/text_style_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/utils/helping_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  var controller = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController());

  ChatArgumnets arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.cECF4FF,
      body: Stack(
        children: [
          Image(
            image: const AssetImage(Assets.imagesProfileBack),
            width: double.infinity,
            height: 0.502.sh,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                space40(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    backButton(context: context),
                    const Text(
                      StringConstants.kUserDetails,
                      style: TextStyleDecoration.s18w600cFFFFFF,
                    ),
                    SizedBox(
                      width: 0.1.sw,
                    ),
                  ],
                ),
                space20(),
                Container(
                  height: 0.12.sh,
                  width: 0.25.sw,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        // image: AssetImage(Assets.imagesUserImage),
                        image: NetworkImage(arguments.profileImage.toString()),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.transparent),
                ),
                Text(
                  arguments.recieverName.toString(),
                  style: TextStyleDecoration.s20w600cFFFFFF,
                ),
                space05(),
                 const Text(
                  StringConstants.kOnline,
                  style: TextStyleDecoration.s12w400c8FB0F4,
                ),
                space10(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _callContainer(
                        title: StringConstants.kCall,
                        image: Assets.imagesChatCall,
                        imageHeight: 15,
                        imageWidth: 15),
                    const SizedBox(
                      width: 10,
                    ),
                    _callContainer(
                        title: StringConstants.kVideo,
                        image: Assets.imagesVideoCallIcon,
                        imageHeight: 16,
                        imageWidth: 22),
                  ],
                ),
                space30(),
                const Row(
                  children: [
                    Text(
                      StringConstants.kProfileDescription,
                      style: TextStyleDecoration.s12w500cFFFFFF,
                    ),
                  ],
                ),
                space30(),

                ///-----encryption tab
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Get.toNamed(encryptionScreen);
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    color: ColorConstants.cFFFFFF,
                    shadowColor: ColorConstants.cFFFFFF,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Image(
                            image: AssetImage(Assets.imagesProfileEncrypt),
                            height: 26,
                            width: 26,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              space05(),
                              const Text(StringConstants.kEncryption,
                                  style: TextStyleDecoration.s14w400c1C2439),
                              space10(),
                              const Text(
                                StringConstants.kProfileEncrpytionDescription,
                                style: TextStyleDecoration.s10w400c626B84,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                space30(),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  color: ColorConstants.cFFFFFF,
                  shadowColor: ColorConstants.cFFFFFF,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          child: Text(
                            StringConstants.kClearChat,
                            style: TextStyleDecoration.s12w500cE21A27,
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          child: Text(
                            StringConstants.kBlockColinCorwin,
                            style: TextStyleDecoration.s12w500cE21A27,
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          child: Text(
                            StringConstants.kReportColinCorwin,
                            style: TextStyleDecoration.s12w500c1C2439,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _callContainer(
      {required String title,
      required String image,
      required double imageHeight,
      required double imageWidth}) {
    return Container(
      height: 40,
      width: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.cFFFFFF.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(image),
            height: imageHeight,
            width: imageWidth,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyleDecoration.s12w500cFFFFFF,
          ),
        ],
      ),
    );
  }
}
