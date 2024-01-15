import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatwave_flutter/chat_screen/controller/chat_screen_controller.dart';
import 'package:chatwave_flutter/chat_screen/model/arguments_model.dart';
import 'package:chatwave_flutter/constants/color_constants.dart';
import 'package:chatwave_flutter/routing.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

var controller = Get.isRegistered<ChatController>()
    ? Get.find<ChatController>()
    : Get.put(ChatController());

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android

      handleMessage(message);
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }
      // if(Platform.isIOS){
      //   forgroundMessage();
      // }
      if (Platform.isAndroid) {
        initLocalNotifications(message);
        showNotification(message);
      }
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.max,
        showBadge: true,
        playSound: true,
        // enableLights: true,
        ledColor: ColorConstants.c1F61E8
        // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
        );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            sound: channel.sound,
            actions: <AndroidNotificationAction>[
          const AndroidNotificationAction(
            'action_1',
            'Action 1',
            showsUserInterface: true,
          ),
          const AndroidNotificationAction('action_2', 'Action 2',
              showsUserInterface: true),
        ]);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  // handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage() async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage);
    }
    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(event);
    });
  }

  void handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'Shubham') {
      Get.toNamed(chatMessagingScreen,
          arguments: ChatArgumnets(
            docId: controller.fcmDocId,
            recieverId: controller.fcmRecieverId,
            profileImage: controller.fcmProfileImage,
            recieverName: controller.fcmName,
          ));
    }
    Future forgroundMessage() async {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: false,
      );
    }
  }
}

class PushNotify {
  Future postNotification(
      {required String token,
      required String title,
      required String subTitle}) async {
    log("Api run done");
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final response = await http.post(url,
        body: jsonEncode({
          "to": token,
          'notification': {
            'title': title,
            'body': subTitle,
            "sound": "default"
          },
          'android': {
            'notification': {
              'notification_count': 23,
            },
          },
          'data': {'type': 'Shubham', 'id': 'Shubham Singh'}
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA6SlUiWc:APA91bHhngjJQN5AHS5KTWoMYLgT6GvnyFo4e-l-o8U02ykZxJcaDYfj1qRdAwax6oFaz_IqZQ49ZqlN-idZp6J26SaOXK-3sSprm6J3rI6nX5fVPYLKPP4cFU0ymtD07fC-ohzs8O7Z'
        });

    log("Api hit done");
    log(jsonDecode(response.body).toString());
    if (response.statusCode == 200) {
      log(jsonDecode(response.body).toString());
      log("Api response done");
      log(token);
      FirebaseMessaging.instance.getToken().then((value) {
        String? token = value;
        log(token!);
      });
      return response.body;
    }
    return response.body;
  }
}
