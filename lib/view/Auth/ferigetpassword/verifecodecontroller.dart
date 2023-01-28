import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/function/handlingData.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/routes.dart';

import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';

import '../../../link_api.dart';

abstract class VerficodeController extends GetxController {
  verifaycode(verifycode);
}

class VerficodeCntrollerInp extends VerficodeController {
  StatusRequest? statusRequest;

  String? email;

  @override
  verifaycode(verifycode) async {
    statusRequest = StatusRequest.loading;
    update();

    APIResponse response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
      'auth/password_forgot/email_verify',
      RequestType.post,
          
          headers: Applink.authedHeaders,
      data: {
        'token': Get.arguments['token'],
        'code': verifycode,
        'user_id': Get.arguments['user_id'],
      },
    );

    if (response.success && response.value != null) {
      Get.offNamed(
        AppRoute.createpassword,
        arguments: response.value,
      );
    } else {
      Get.defaultDialog(
        title: "Warning",
        middleText: response.message ,
      );
      statusRequest = StatusRequest.failure;
      update();
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
