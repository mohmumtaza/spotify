import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initPushNotification() async {
    try {
      // Izinkan pengguna untuk memberikan izin notifikasi
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      print('User granted permission: ${settings.authorizationStatus}');

      // Dapatkan token messaging
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');

      // Handler untuk pesan yang diterima saat aplikasi dalam keadaan tertutup
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        print("terminatedNotification : ${message?.notification?.title}");
      });

      // Handler untuk pesan yang diterima saat aplikasi dalam keadaan background
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    } catch (e) {
      print('Error initializing push notifications: $e');
    }
  }
  

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    try {
      print('Message received in background: ${message.notification?.title}');
      // Handle pesan yang diterima saat aplikasi berada dalam keadaan background di sini
    } catch (e) {
      print('Error handling background message: $e');
    }
  }
}
