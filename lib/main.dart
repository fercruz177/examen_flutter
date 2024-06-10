import 'dart:convert';

import 'package:examen_flutter/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:examen_flutter/core/service_locator.dart' as sl;
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.initNotification();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      NotificationService.showLocalNotification(message.notification!,message);
    }
  });

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('qwerty fcm token:');
  print(fcmToken);

  sl.init();
  final themeStr = await rootBundle.loadString('assets/styles/main_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(theme));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp();
  await NotificationService.initNotification();
  //NotificationService.showLocalNotificationX();
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
    //NotificationService.showLocalNotification(message.notification!,message);
  }
}


class MyApp extends StatelessWidget {
  MyApp(this.theme, {super.key});

  ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: theme,
      routerConfig: myRouter,
    );
  }
}


