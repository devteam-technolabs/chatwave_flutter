import 'dart:async';

import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/generated/assets.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:chatwave_flutter/routing/navigation_helper.dart';
import 'package:chatwave_flutter/routing/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      // NavigationHelper().navigateToRoutes(route: RoutesConstants.loginScreen, caseType: 1);
      Get.offNamed(loginScreen);
    });
    return Scaffold(
      body:Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConstants.c1F61E8,
        alignment: Alignment.center,
        child: const Image(image: AssetImage(Assets.imagesSplashLogo),height: 95,width: 91,),
      ),
    );
  }
}



