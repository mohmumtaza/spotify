import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/controller/controller.dart';
import 'package:spotify/controller/notification_handler.dart';
import 'package:spotify/firebase_options.dart';

// Docker Testing -- Set API
import 'package:appwrite/appwrite.dart';




void main()async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);


await Get.putAsync(() async => await SharedPreferences.getInstance());
await FirebaseMessagingHandler().initPushNotification();

  runApp(
    GetMaterialApp(
      home: MusicApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
