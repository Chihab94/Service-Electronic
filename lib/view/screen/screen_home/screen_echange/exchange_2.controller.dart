import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:http/http.dart' as http;
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/link_api.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';

import '../../../../Data/model/transfer.model.dart';
import '../../../../core/class/statusRequest.dart';
import '../../../../core/services/auth.service.dart';
import '../../../../core/services/main.service.dart';
import '../../../widget/dialogs.view.dart';

class Exchone2Controller extends GetxController {
  MainService mainSerivice = Get.find();

  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;

  late CurrencyModel sendedCurrency;
  late CurrencyModel receivedCurrency;
  late double sendedBalance;
  late double receivedBalance;
  Map<String, TextEditingController> dataControllers = {};

  UserModel get user => Get.find<AuthSerivce>().currentUser.value!;

  // late TextEditingController userWallet;
  GlobalKey<FormState> Confirm = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    // userWallet = TextEditingController();
    sendedCurrency = Get.arguments['sended_currency'];
    receivedCurrency = Get.arguments['received_currency'];
    sendedBalance = Get.arguments['sended_balance'];
    receivedBalance = Get.arguments['received_balance'];
    for (String name in sendedCurrency.data.keys) {
      dataControllers[name] = TextEditingController();
    }
  }

//=========== متغيرات الصور =======================================
  File? imageproof;

  // ============ فنكشن الصورة الاثبات ==========================
  Future<void> ublodimage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: sendedCurrency.pickType.source,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      // imageproof = File(pickedImage.path);
      imageproof =
          await FlutterNativeImage.compressImage(pickedImage.path, quality: 15);
    } else {}
    update();
  }

//=========== فنكشن خاص بصفحة الدفع ===================================
  Confirme() async {
    statusRequest.value = StatusRequest.loading;
    update();
    if (Confirm.currentState!.validate() && !sendedCurrency.proofIsRequired ||
        Confirm.currentState!.validate() &&
            sendedCurrency.proofIsRequired &&
            imageproof != null) {
      APIResponse response = await Get.find<MainService>()
          .storageDatabase
          .storageAPI!
          .request(
              '${Applink.transfers}/${sendedCurrency.id == user.platformSettings.platformCurrency.id ? 'withdraw' : 'create'}',
              RequestType.post,
              headers: Applink.authedHeaders,
              log: true,
              data: {
            'received_balance': sendedBalance.toString(),
            'sended_currency_id': sendedCurrency.id.toString(),
            'received_currency_id': receivedCurrency.id.toString(),
            'data': jsonEncode({
              for (String name in dataControllers.keys)
                name: dataControllers[name]!.text,
            }),
            // 'wallet': userWallet.text,
          },
              files: [
            if (sendedCurrency.proofIsRequired)
              await http.MultipartFile.fromPath("proof", imageproof!.path)
          ]);
      if (response.success) {
        statusRequest.value = StatusRequest.success;

        await TransferModel.loadAll(TransferTarget.transfers);
        await UserModel.refreshUser();

        Get.back();
      } else {
        Get.defaultDialog(
          title: 'Transfer error',
          middleText: response.message,
        );
        statusRequest.value = StatusRequest.failure;
      }
      update();
    } else {
      statusRequest.value = StatusRequest.failure;
      update();
      Get.defaultDialog(
        title: 'Transfer error',
        middleText: 'Please fill all data',
      );
    }
  }
}
