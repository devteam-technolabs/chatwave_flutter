import 'package:chatwave_flutter/authentication_screen/screen/login_screen.dart';
import 'package:chatwave_flutter/authentication_screen/screen/otp_screen.dart';
import 'package:chatwave_flutter/authentication_screen/screen/profile_setup_screen.dart';
import 'package:chatwave_flutter/calls_screen/screens/new_call%20_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/all_contacts_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/chat_messaging_group_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/chat_messaging_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/encryption_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/group_profile_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/new_group_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/story_view_screen.dart';
import 'package:chatwave_flutter/chat_screen/screen/user_profile_screen.dart';
import 'package:chatwave_flutter/custom_bottom_bar/screen/custom_bottom_bar.dart';
import 'package:chatwave_flutter/edit_profile_screen/screen/edit_profile_screen.dart';
import 'package:chatwave_flutter/setting/screens/alert_tones_list.dart';
import 'package:chatwave_flutter/setting/screens/change_number_screen.dart';
import 'package:chatwave_flutter/setting/screens/my_contacts_screen.dart';
import 'package:chatwave_flutter/setting/screens/privacy_security_screen.dart';
import 'package:chatwave_flutter/setting/screens/setting_screen.dart';
import 'package:chatwave_flutter/setting/screens/sound_screen.dart';
import 'package:chatwave_flutter/setting/screens/sound_type_screen.dart';
import 'package:chatwave_flutter/splash_screen/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

const String splashScreen = '/';
const String loginScreen = '/loginScreen';
const String otpScreen = '/otpScreen';
const String profileSetupScreen = '/profileSetupScreen';
const String settingScreen = '/settingScreen';
const String soundScreen = '/soundScreen';
const String alertTones = '/alertTones';
const String customBottomBar = '/customBottomBar';
const String chatMessagingScreen = '/chatMessagingScreen';
const String soundTypeScreen = '/soundTypeScreen';
const String privacyAndSecurityScreen = '/privacyAndSecurityScreen';
const String myContactScreen = '/myContactScreen';
const String changeNumberScreen = '/changeNumberScreen';
const String allUsersChatScreen = '/allUsersChatScreen';
const String newGroupScreen = '/newGroupScreen';
const String userProfileScreen = '/userProfileScreen';
const String encryptionScreen = '/encryptionScreen';
const String groupProfileScreen = '/groupProfileScreen';
// const String storyViewScreen = '/storyViewScreen';
const String newCallScreen = '/newCallScreen';
const String editProfileScreen = '/editProfileScreen';
const String chatMessagingGroupScreen = '/chatMessagingGroupScreen';



List<GetPage<dynamic>> getRoutes = [
  GetPage(name: splashScreen, page: () => const SplashScreen()),
  GetPage(name: loginScreen, page: () => LoginScreen()),
  GetPage(name: otpScreen, page: () => OtpScreen()),
  GetPage(name: profileSetupScreen, page: () => ProfileSetupScreen()),
  GetPage(name: settingScreen, page: () => SettingScreen()),
  GetPage(name: soundScreen, page: () => SoundScreen()),
  GetPage(name: alertTones, page: () => AlertTones()),
  GetPage(name: customBottomBar, page: () => CustomBottomBar()),
  GetPage(name: chatMessagingScreen, page: () => ChatMessagingScreen()),
  GetPage(name: soundTypeScreen, page: () => SoundTypeScreen()),
  GetPage(name: privacyAndSecurityScreen, page: () => PrivacyAndSecurityScreen()),
  GetPage(name: myContactScreen, page: () => MyContactScreen()),
  GetPage(name: changeNumberScreen, page: () => ChangeNumberScreen()),
  GetPage(name: allUsersChatScreen, page: () => AllUsersChatScreen()),
  GetPage(name: newGroupScreen, page: () => NewGroupScreen()),
  GetPage(name: userProfileScreen, page: () => UserProfileScreen()),
  GetPage(name: encryptionScreen, page: () => EncryptionScreen()),
  GetPage(name: groupProfileScreen, page: () => GroupProfileScreen()),
  // GetPage(name: storyViewScreen, page: () => StoryViewScreen()),
  GetPage(name: newCallScreen, page: () => NewCallScreen()),
  GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
  GetPage(name: chatMessagingGroupScreen, page: () => ChatMessagingGroupScreen()),
];
