import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/constants/firebase_key_constants.dart';
import 'package:chatwave_flutter/firebase_services/services/firebase_services.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chatwave_flutter/routing.dart' as router;



@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseConstants.messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Map<int, Color> color = {
    50: ColorConstants.c1F61E8.withOpacity(.1),
    100: ColorConstants.c1F61E8.withOpacity(.2),
    200: ColorConstants.c1F61E8.withOpacity(.3),
    300: ColorConstants.c1F61E8.withOpacity(.4),
    400: ColorConstants.c1F61E8.withOpacity(.5),
    500: ColorConstants.c1F61E8.withOpacity(.6),
    600: ColorConstants.c1F61E8.withOpacity(.7),
    700: ColorConstants.c1F61E8.withOpacity(.8),
    800: ColorConstants.c1F61E8.withOpacity(.9),
    900: ColorConstants.c1F61E8.withOpacity(1),
  };

  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xff1F61E8, color);
    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'ChatWave',
            debugShowCheckedModeBanner: false,
            navigatorObservers: [ClearFocusOnPush()],
            getPages: router.getRoutes,
            initialRoute: FirebaseAuth.instance.currentUser != null ? customBottomBar : splashScreen,
            //initialRoute: customBottomBar,
            theme: ThemeData(
              useMaterial3: false,
              fontFamily: 'Poppins',
              primarySwatch: colorCustom,
            ),
          );
        });
  }
}

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}
