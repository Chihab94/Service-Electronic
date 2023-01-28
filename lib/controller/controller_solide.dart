import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/view/screen/screen_home/screen_echange/echonge_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/statusRequest.dart';
import '../core/services/auth.service.dart';
import '../core/services/main.service.dart';

class MyEchongeController extends GetxController {
  MainService mainSerivice = Get.find();

  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;

  GlobalKey<FormState> solidFormKey = GlobalKey<FormState>();
//====================== متغيرات العملات ===============================
  late TextEditingController send;
  late TextEditingController resevied;
  RxList<CurrencyModel> solid = <CurrencyModel>[].obs;
  RxList<CurrencyModel> solidTo = <CurrencyModel>[].obs;
  Rx<int> from = (-1).obs;
  Rx<int> to = (-1).obs;

// =============== ارسال البيانات الى الصفحة اتمام عملية الدفع =======

  reservation() async {
    if (solidFormKey.currentState!.validate()) {
      await Get.to(() => echonge_2(), arguments: {
        'sended_currency': solidTo[to.value],
        'received_currency': solid[from.value],
        'sended_balance': double.parse(send.text),
        'received_balance': double.parse(resevied.text),
      });
    } else {}
    update();
  }

  calculateSend(String value) {
    if (from.value == -1 || to.value == -1) return;
    if (send.text.isNotEmpty) {
      resevied.text = ((double.tryParse(send.text) ?? 0) *
              solid[from.value].dPrices["${solidTo[to.value].id}"]['buy'])
          .toStringAsFixed(2);
    } else {
      resevied.text = 0.toString();
    }
  }

  calculateReceived(String value) {
    if (from.value == -1 || to.value == -1) return;
    if (resevied.text.isNotEmpty) {
      send.text = ((double.tryParse(resevied.text) ?? 0) /
              solid[from.value].dPrices["${solidTo[to.value].id}"]['buy'])
          .toStringAsFixed(2);
    } else {
      resevied.text = 0.toString();
    }
  }

  UserModel get user => Get.find<AuthSerivce>().currentUser.value!;
  @override
  void onInit() {
    send = TextEditingController();
    resevied = TextEditingController();
    refreshPage().then((_) {
      statusRequest.value = StatusRequest.success;
      update();
    });
    from.listen((from) {
      solidTo.value = from != -1 ? solid[from].prices.keys.toList() : [];
    });
    super.onInit();
  }

  Future refreshPage() async {
    var items = await CurrencyModel.loadAll();
    solid.value = items
        .where((currency) =>
            currency.id != user.platformSettings.platformCurrency.id &&
            currency.dPrices.isNotEmpty)
        .toList();
    from.value = -1;
    to.value = -1;
    send.clear();
    resevied.clear();
    update();
  }

  @override
  void dispose() {
    send.dispose();
    resevied.dispose();
    super.dispose();
  }
}
