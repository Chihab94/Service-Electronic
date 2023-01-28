
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:service_electronic/view/screen/screen_home/screen_Service/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/localization/localiztioncontroller.dart';
import 'core/localization/translation.dart';

import 'core/services/main.service.dart';
import 'core/services/notifiction.service.dart';
import 'routes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  FlutterError.onError = (details) {
    print(details.exception);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Get.put(MainService()).init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationService notificationService = Get.find();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslation(),
      locale: Get.find<LocaleController>().language,
      theme: ThemeData(fontFamily: "PTSerif"),
      getPages: AppRoute.routes,
    );
  }
}
