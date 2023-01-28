import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/function/handlingData.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';

import '../../../link_api.dart';

abstract class NewpasswordController extends GetxController {
  newpassword();
}

class NewpasswordControllerInp extends NewpasswordController {
  var NewpasswordFormKey = GlobalKey<FormState>();
  late TextEditingController Password;
  late TextEditingController ConfirmPassword;

  @override
  void onInit() {
    Password = TextEditingController();
    ConfirmPassword = TextEditingController();
    super.onInit();
  }

  StatusRequest? statusRequest;
  String? email;

  @override
  newpassword() async {
    if (NewpasswordFormKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var _response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
        'auth/password_forgot/password_reset',
        RequestType.post,
          
          headers: Applink.authedHeaders,
        data: {
          'token': Get.arguments['token'],
          'user_id': Get.arguments['user_id'],
          'new_password': ConfirmPassword.text,
        },
      );

      if (_response.success) {
        Get.offNamed(AppRoute.login);
      } else {
        Get.defaultDialog(
          title: "Warning",
          middleText: _response.message ,
        );
        statusRequest = StatusRequest.failure;
        update();
      }
    }

    @override
    void onDelete() {
      Password.dispose();
      ConfirmPassword.dispose();
      super.dispose();
    }
  }
}
