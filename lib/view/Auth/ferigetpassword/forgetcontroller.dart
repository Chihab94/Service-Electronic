import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/function/handlingData.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';

import '../../../link_api.dart';

abstract class ForgetController extends GetxController {
  forgetpassword();
}

class ForgetcrollerInp extends ForgetController {
  GlobalKey<FormState> formpassword = GlobalKey<FormState>();
  late TextEditingController email;
  Map<String, String> errors = {};

  MainService mainService = Get.find();

  StatusRequest? statusRequest;

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  forgetpassword() async {
    if (formpassword.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      APIResponse response =
          await mainService.storageDatabase.storageAPI!.request(
        'auth/password_forgot',
        RequestType.post,
          
          headers: Applink.authedHeaders,
        data: {
          'email': email.text,
        },
      );

      if (response.success && response.value != null) {
        Get.offNamed(
          AppRoute.verificode,
          arguments: response.value,
        );
      } else {
        if (response.errors != null) {
          errors = response.errors!;
          update();
          formpassword.currentState!.validate();
        } else {
          Get.defaultDialog(
            title: "Email verification",
            middleText: response.message,
          );
        }
        statusRequest = StatusRequest.failure;
        update();
      }
    }

    @override
    void onInit() {
      email = TextEditingController();
      super.onInit();
    }

    @override
    void dispose() {
      email.dispose();
      super.dispose();
    }
  }
}
