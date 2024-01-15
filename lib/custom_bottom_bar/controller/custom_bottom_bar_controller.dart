import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomBarController extends GetxController {
  int bottomSelectedIndex = 0;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  RxDouble indicatorPosition = 0.0.obs;

  // Method to update the indicator position
  @override
  void onInit() {
    super.onInit();
  }

  void pageChanged(int index) {
    bottomSelectedIndex = index;
    update();
  }

  void bottomTapped(int index) {
    bottomSelectedIndex = index;
    pageController.jumpToPage(
      index,
    );
    update();
  }
}
