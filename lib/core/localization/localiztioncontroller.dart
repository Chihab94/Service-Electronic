import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:service_electronic/core/services/main.service.dart';

class LocaleController extends GetxService {
  Locale language = const Locale('en');

  MainService myservices = Get.find();

  Future changelang(String langcode) async {
    language = Locale(langcode);
    // myservices.sharedPreferences.setString('lang', langcode);
    await myservices.storageDatabase
        .collection('settings')
        .set({'language': langcode});
    Get.updateLocale(language);
  }

  @override
  void onInit() {
    // String? sharedpreflang = myservices.sharedPreferences.getString("lang");

    // myservices.storageDatabase
    //     .document('settings/language')
    //     .get()
    //     .then((sharedpreflang) {
    //   if (sharedpreflang == "ar") {
    //     language = const Locale("ar");
    //     // }
    //     // else if (sharedpreflang == "en") {
    //     //   language = const Locale("en");
    //   } else {
    //     language = const Locale("en");
    //   }
    // });
    super.onInit();
  }
}
