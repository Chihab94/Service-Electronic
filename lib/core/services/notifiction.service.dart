import 'dart:convert';

import 'package:service_electronic/Data/model/notification.model.dart';
import 'package:service_electronic/Data/model/transfer.model.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'main.service.dart';

class NotificationService extends GetxService {
  MainService mainService = Get.find();

  RxInt newTransfer = 0.obs;
  // RxInt newProducts = 0.obs;
  RxInt newPurchaseRequests = 0.obs;
  RxInt newPurchases = 0.obs;
  RxInt newMobileServices = 0.obs;
  RxInt newServices = 0.obs;
  RxInt allNewServices = 0.obs;

  IO.Socket? socket;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaingConfiure() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  bool connectionError = false;
  bool? connected;

  init(String token) async {
    await messaingConfiure();
    print('auth token: $token');
    socket = IO.io(Applink.socketUrl, {
      'autoConnect': false,
      'transports': ['websocket'],
      'path': '/api/'
    });
    socket!.onConnect((_) {
      socket!.emit('auth', token);
      if (!connectionError) return;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('143'.tr),
              ),
              const Icon(
                Icons.wifi,
                color: Color.fromARGB(255, 40, 248, 50),
              )
            ],
          ),
        ),
      );
    });
    socket!.onDisconnect((_) => print('onDisconnect: disconnect'));
    socket!.onConnectError((data) {
      print(data.toString());
      connectionError = true;

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('144'.tr),
              ),
              const Icon(
                Icons.wifi_off,
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      );
    });
    socket!.onError((data) {
      print(data);
    });
    socket!.on('notifications', (args) async {
      NotificationModel notification = NotificationModel.fromMap(args);
      await TransferModel.loadAll(TransferTarget.transfers);
      await UserModel.refreshUser();
      Get.snackbar(
        notification.title,
        notification.message,
        backgroundColor: Colors.white,
        icon: const Icon(Icons.notifications),
      );
    });
    socket!.connect();

    socket!.on('auth-resualt', (data) async {
      connected = data['success'];
      if (connected == false) Get.find<AuthSerivce>().signout();
    });
  }

  disconnect() {
    socket?.disconnect();
    socket?.clearListeners();
    socket?.close();
    socket?.dispose();
    socket = null;
  }
}
