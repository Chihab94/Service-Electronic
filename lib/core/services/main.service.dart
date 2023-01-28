import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storage_database/storage_database.dart';

import '../localization/localiztioncontroller.dart';
import 'notifiction.service.dart';

class MainService extends GetxService {
  late StorageDatabase storageDatabase;

  Future initCollections() async {
    await storageDatabase.collection('currencies').set({});
    await storageDatabase.collection('categories').set({});
    await storageDatabase.collection('offers').set({});
    await storageDatabase.collection('offer_requests').set({});
    await storageDatabase.collection('products').set({});
    await storageDatabase
        .collection('purchases')
        .set({'seller': {}, 'user': {}});
    await storageDatabase.collection('transfers').set({
      'transfers': {},
      'rechares': {},
      'withdraws': {},
    });
    await storageDatabase.collection('exchanges').set({});
    await storageDatabase.collection('notifications').set({});

    await storageDatabase.collection('settings').set({});
  }

  Future init() async {
    await Firebase.initializeApp();
    storageDatabase = await StorageDatabase.getInstance();
    await storageDatabase.initExplorer();
    await storageDatabase.explorer!.initNetWorkFiles();
    // var dir = storageDatabase.explorer!.directory('network-files');
    // dir.stream().listen((event) {
      // print(event);
    // });
    // await storageDatabase.clear();
    // storageDatabase.initAPI(
    //   apiUrl: Applink.apiUrl,
    // );

    await initCollections();

    if (await storageDatabase.collection('settings').get() == {}) {
      await storageDatabase
          .collection('settings')
          .set({'token': '', 'authed': false, 'language': 'en'});
    }
    LocaleController localeService = Get.put(LocaleController());
    localeService.language = Locale(
        await storageDatabase.document('settings/language').get() ?? 'en');
    AuthSerivce authService = Get.put(AuthSerivce());
    storageDatabase.initAPI(
      apiUrl: Applink.apiUrl,
    );
    Get.put(NotificationService());

    authService.authed.value =
        await storageDatabase.document('settings/authed').get() ?? false;
    if (authService.authed.value) {
      await authService.onAuth(refresh: true);
    }
  }
}
