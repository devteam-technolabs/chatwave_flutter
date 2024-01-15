import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget space05() {
  return SizedBox(
    height: .005.sh,
  );
}

Widget space10() {
  return SizedBox(
    height: .010.sh,
  );
}

Widget space15() {
  return SizedBox(
    height: .015.sh,
  );
}

Widget space20() {
  return SizedBox(
    height: .020.sh,
  );
}

Widget space30() {
  return SizedBox(
    height: .030.sh,
  );
}

Widget space40() {
  return SizedBox(
    height: .040.sh,
  );
}

Widget commonPadding({required Widget child}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
    child: child,
  );
}

Widget commonButton(
    {required String title, required VoidCallback onTap, Color? buttonColor,Color? textColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image(image:const AssetImage(Assets.imagesCommonButton),height: 59,width: 132,color: buttonColor ?? ColorConstants.c1F61E8,),
        Text(title,style: TextStyle(color: textColor ?? ColorConstants.cFFFFFF,fontWeight: FontWeight.w600,fontSize: 16),)
      ],
    ),
  );
}


Widget backButton({required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Container(
       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.cFFFFFF.withOpacity(0.2),
      ),
      child: Image.asset(
        Assets.imagesBackButtonIcon,
        height: 8,
        width: 14,
        color: ColorConstants.cFFFFFF,
      ),
    ),
  );
}
