import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:service_electronic/Data/model/offer.model.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/routes.dart';
import 'package:service_electronic/view/widget/dialogs.view.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';

class OfferRequestController extends GetxController {
  // StatusRequest statusRequest = StatusRequest.success;
  GlobalKey<FormState> requestKey = GlobalKey<FormState>();
  OfferModel offer = Get.arguments;
  Map<String, String> errors = {};

  Rx<UserModel?> get user => Get.find<AuthSerivce>().currentUser;
  RxBool validateBalance = true.obs;
  double totalPrice = 0;

  String selectedSubOffer = '-1';

  RxMap<String, TextEditingController> fieldsControllers =
      <String, TextEditingController>{}.obs;

  TextEditingController getFieldController(String name) {
    if (!fieldsControllers.containsKey(name)) {
      fieldsControllers[name] = TextEditingController();
    }
    return fieldsControllers[name]!;
  }

  @override
  void dispose() {
    fieldsControllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future submit() async {
    if (totalPrice > user.value!.balance) {
      validateBalance.value = false;
      update();
    }
    if (requestKey.currentState!.validate() && validateBalance.value) {
      DialogsView.loading().show();
      APIResponse response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
        'offer_request/${offer.id}/create',
        RequestType.post,
          
          headers: Applink.authedHeaders,
        data: {
          'sub_offer': selectedSubOffer,
          for (String name in fieldsControllers.keys)
            name: fieldsControllers[name]!.text,
        },
      );
      Get.back();
      if (response.success) {
        await DialogsView.message(
          'Request offer',
          response.message,
        ).show();
        Get.toNamed(AppRoute.offersCart);
      } else {
        if (response.errors != null) {
          errors = response.errors!;
          validateBalance.value = !errors.containsKey('balance');
          update();
          requestKey.currentState!.validate();
        } else {
          DialogsView.message(
            'Request offer',
            response.message,
          ).show();
        }
      }
    }
  }
}
