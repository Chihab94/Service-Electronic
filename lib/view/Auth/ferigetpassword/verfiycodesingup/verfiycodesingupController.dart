import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/function/handlingData.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';

import '../../../../link_api.dart';

abstract class VerficodesingupController extends GetxController {
  singup();
  verifaycodesingup(String verfycodesingup);
}

class VerficodesingupCntrollerInp extends VerficodesingupController {
  String? email; // hada 3lash

  StatusRequest? statusRequest;

  @override
  singup() {}
  @override
  verifaycodesingup(verfycodesingup) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
              'auth/email_verify',
              RequestType.post,
          
          headers: Applink.authedHeaders,
              data: {
                'user_id': Get.arguments['user_id'],
                'token': Get.arguments['token'],
                "code": verfycodesingup,
              },
              log: true,
            );
    if (response.success) {
      Get.offNamed(AppRoute.login);
      Get.snackbar(
          margin: const EdgeInsets.all(15),
          icon: const Icon(
            Icons.verified_outlined,
            color: Colors.green,
            size: 30,
          ),
          (""),
          (""),
          backgroundColor: Colors.white70,
          titleText: Text(
            "60".tr,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          messageText: FittedBox(
              child: Text(
            "61".tr,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )));
    } else {
      Get.defaultDialog(
        title: "Warning",
        middleText: response.message,
      );
      statusRequest = StatusRequest.failure;
      update();
    }
  }

  @override
  void onInit() {
    email = Get.arguments['Email'];
    super.onInit();
  }
}
