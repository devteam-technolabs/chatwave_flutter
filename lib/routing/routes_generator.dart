import 'package:chatwave_flutter/authentication_screen/screen/login_screen.dart';
import 'package:chatwave_flutter/authentication_screen/screen/otp_screen.dart';
import 'package:chatwave_flutter/authentication_screen/screen/profile_setup_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/chat_messaging_screen.dart';
import 'package:chatwave_flutter/routing/routes_constants.dart';
import 'package:chatwave_flutter/setting/screens/alert_tones_list.dart';
import 'package:chatwave_flutter/setting/screens/my_contacts_screen.dart';
import 'package:chatwave_flutter/setting/screens/setting_screen.dart';
import 'package:chatwave_flutter/setting/screens/sound_screen.dart';
import 'package:chatwave_flutter/splash_screen/screen/splash_screen.dart';
import 'package:chatwave_flutter/custom_bottom_bar/screen/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;

    switch (settings.name) {
      case RoutesConstants.splashScreen:
        widgetScreen = const SplashScreen();
        break;
      case RoutesConstants.loginScreen:
        widgetScreen = LoginScreen();
        break;
      case RoutesConstants.otpScreen:
        widgetScreen = OtpScreen();
        break;
      case RoutesConstants.profileSetupScreen:
        widgetScreen = ProfileSetupScreen();
        break;

        case RoutesConstants.settingScreen:
        widgetScreen =  SettingScreen();
        break;
        case RoutesConstants.soundScreen:
        widgetScreen =  SoundScreen();
        break;
        case RoutesConstants.alertTones:
        widgetScreen =  AlertTones();

      case RoutesConstants.customBottomBar:
        widgetScreen = CustomBottomBar();

        break;
      case RoutesConstants.chatMessagingScreen:
        widgetScreen = ChatMessagingScreen();
        break;
            case RoutesConstants.myContactExcept:
        widgetScreen = MyContactScreen();
        break;

      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(
        routeName: settings.name, page: () => widgetScreen, settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}
