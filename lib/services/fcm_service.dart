import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_service.dart';

class FcmService {
  static init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    NotificationService.initNotification();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Data: ${message.data}');

      if (message.notification != null) {
        print('Notification: ${message.notification}');
        NotificationService.showLocalNotification(
            message.notification!, message);
      }
    });

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('qwerty fcm token:');
    print(fcmToken);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (message.notification != null) {
    print('Notification: ${message.notification}');
  }
}
