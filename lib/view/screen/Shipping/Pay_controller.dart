import 'dart:convert';
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:service_electronic/view/widget/dialogs.view.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';

import '../../../Data/model/transfer.model.dart';

class PayController extends GetxController {
  GlobalKey<FormState> protfolio = GlobalKey<FormState>();
  AuthSerivce authSerivce = Get.find();

  StatusRequest statusRequest = StatusRequest.success;

  UserModel get user => authSerivce.currentUser.value!;

  RxMap<int, CurrencyModel> platofromCurrencies = <int, CurrencyModel>{}.obs;

  int display = 1;

  int currenctCurrencyId = -1;
  late TextEditingController dibosit;
  late TextEditingController withdraw;
  late TextEditingController transfier;
  late TextEditingController blanci;
  File? imageproof;

  double sellBalance = 0;
  double rechargeBalance = 0;

  Future refreshPage() async {
    await UserModel.refreshUser();
    sellBalance = 0;
    rechargeBalance = 0;
    display = 1;
    currenctCurrencyId = -1;
    dibosit.clear();
    withdraw.clear();
    transfier.clear();
    blanci.clear();
    imageproof = null;
    platofromCurrencies.value = {
      for (CurrencyModel currency
          in (user.platformSettings.platformCurrency.prices.keys))
        currency.id: currency
    };
    update();
  }

  dibosi() async {
    if (protfolio.currentState!.validate() && imageproof != null) {
      statusRequest = StatusRequest.loading;
      update();
      CurrencyModel platformCurrency =
          authSerivce.currentUser.value!.platformSettings.platformCurrency;

      APIResponse response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
        '${Applink.transfers}/recharge',
        RequestType.post,
          
          headers: Applink.authedHeaders,
        data: {
          'sended_balance': dibosit.text,
          'sended_currency_id':
              platofromCurrencies[currenctCurrencyId]!.id.toString(),
          'received_currency_id': platformCurrency.id.toString(),
        },
        files: [
          await http.MultipartFile.fromPath("proof", imageproof!.path),
        ],
      );
      if (response.success) {
        statusRequest = StatusRequest.success;
        await TransferModel.loadAll(TransferTarget.recharges);
        await UserModel.refreshUser();
        Get.back();
      } else {
        Get.defaultDialog(
          title: 'Transfer error',
          middleText: response.message,
        );
        statusRequest = StatusRequest.failure;
        update();
      }
    }
  }

  calculateRechareBalance(String text) {
    if (text.isEmpty || currenctCurrencyId == -1) {
      rechargeBalance = 0;
    } else {
      double value = double.tryParse(text) ?? 0;
      rechargeBalance = value *
          platofromCurrencies[currenctCurrencyId]!
              .dPrices["${user.platformSettings.platformCurrency.id}"]['sell'];
    }
    update();
  }

  calculateBalance(String text) {
    if (text.isEmpty || currenctCurrencyId == -1) {
      sellBalance = 0;
    } else {
      double value = double.tryParse(text) ?? 0;
      sellBalance = value *
          platofromCurrencies[currenctCurrencyId]!
              .dPrices["${user.platformSettings.platformCurrency.id}"]['buy'];
    }
    update();
  }

  Withdraw() async {
    if (protfolio.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      APIResponse response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
        '${Applink.transfers}/withdraw',
        RequestType.post,
          
          headers: Applink.authedHeaders,
        data: {
          'received_balance': blanci.text,
          'sended_currency_id':
              user.platformSettings.platformCurrency.id.toString(),
          'received_currency_id':
              platofromCurrencies[currenctCurrencyId]!.id.toString(),
          'wallet': withdraw.text,
          'for_what': 'withdraw'
        },
      );
      if (response.success) {
        statusRequest = StatusRequest.success;
        await TransferModel.loadAll(TransferTarget.withdraws);
        await UserModel.refreshUser();
        Get.back();
      } else {
        Get.defaultDialog(
          title: 'Transfer error',
          middleText: response.message,
        );
        statusRequest = StatusRequest.failure;
        update();
      }
    }
  }

  transfer() async {
    if (protfolio.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      APIResponse response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
        'send_mony',
        RequestType.post,
          
          headers: Applink.authedHeaders,
        data: {
          'email': transfier.text,
          'balance': blanci.text,
        },
      );
      if (response.success) {
        await UserModel.refreshUser();
        Get.back();
      } else {
        statusRequest = StatusRequest.success;
        update();
        DialogsView.message(
          'Balance Transfer',
          response.message,
        ).show();
      }
    }
  }

  @override
  void onInit() {
    withdraw = TextEditingController();
    blanci = TextEditingController();
    transfier = TextEditingController();
    dibosit = TextEditingController();

    platofromCurrencies.value = {
      for (CurrencyModel currency
          in (user.platformSettings.platformCurrency.prices.keys))
        currency.id: currency
    };
    super.onInit();
  }

  @override
  void dispose() {
    withdraw.dispose();
    blanci.dispose();
    transfier.dispose();
    dibosit.dispose();
    super.dispose();
  }

//================ فنكشن رفع الصور ======================================
  Future<void> ublodimage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      imageproof =
          await FlutterNativeImage.compressImage(pickedImage.path, quality: 15);
      update();
    } else {}
    update();
  }

  historque() {
    Get.toNamed(AppRoute.homeCart);
    update();
  }
}
