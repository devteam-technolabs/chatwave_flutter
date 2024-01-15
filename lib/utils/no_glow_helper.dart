import 'package:flutter/material.dart';

class NoGlowHelper extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;

  }
}