import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/routes.dart';
import 'package:service_electronic/view/widget/dialogs.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';

import '../../../core/services/auth.service.dart';

class SellerController extends GetxController {
  MainService mainService = Get.find();
  Map countries = {};

  // StatusRequest statusRequest = StatusRequest.success;

  File? imageverification;

  File? imageaddress;

  //============= فنكشن رفع الصور الهوية ================
  Future<void> ublodimage() async {
    final pickedImage = await ImagePicker().pickImage(
      // TODO: set it capera source
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      // imageverification = File(pickedImage.path);
      imageverification =
          await FlutterNativeImage.compressImage(pickedImage.path, quality: 15);
    } else {}
    update();
  }

  //============= فنكشن رفع الصور العنوان ================
  Future<void> ublodimageaddress() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      // imageaddress = File(pickedImage.path);
      imageaddress =
          await FlutterNativeImage.compressImage(pickedImage.path, quality: 15);
      //
    } else {}
    update();
  }

  GlobalKey<FormState> sellerVerifiction = GlobalKey<FormState>();
  late TextEditingController nemstore;
  late TextEditingController address;
  int verifyType = -1;

  // RxMap deliveryStates = {}.obs;
  List<String> get deliveryStates => [
        for (String state
            in (countries["Algeria"]?['states'] as Map? ?? {}).keys)
          if (!deliveryStatePrices.keys.contains(state)) state
      ];
  RxMap<String, DeliveryStatePrice> deliveryStatePrices =
      <String, DeliveryStatePrice>{}.obs;

//=============== خاص بالبلد ========================
  RxString slectedCountry = "-1".obs;
  void changeCountry(String value) {
    slectedCountry.value = value;
    update();
  }

  //============= خاص بالولاية ========================
  RxString slectedState = '-1'.obs;
  void changeState(String value) {
    slectedState.value = value;
    update();
  }

  addDeleveryStatePrice(DeliveryStatePrice deliveryStatePrice) {
    deliveryStatePrices[deliveryStatePrice.state] = (deliveryStatePrice);
    // print(deliveryStates);
    // deliveryStates.remove(deliveryStates[deliveryStatePrice.state]);
    // print(deliveryStates);
    update();
  }

  removeDeleveryStatePrice(DeliveryStatePrice deliveryStatePrice) {
    // deliveryStates[deliveryStatePrice.state] =
    //     countries["Algeria"]['states'][deliveryStatePrice.state];
    deliveryStatePrices.remove(deliveryStatePrice.state);
    update();
  }

  bool showValidate = false;

  verifiyIdentity() async {
    showValidate = imageverification == null || imageaddress == null;
    if (showValidate) {
      update();
      return;
    }
    DialogsView.loading().show();
    APIResponse response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
      Applink.identityVerify,
      RequestType.post,
      headers: Applink.authedHeaders,
      files: [
        await http.MultipartFile.fromPath(
          'identity_image',
          imageverification!.path,
        ),
        await http.MultipartFile.fromPath(
          'address_image',
          imageaddress!.path,
        ),
      ],
    );
    Get.back();
    if (response.success) {
      Get.find<AuthSerivce>().currentUser.value =
          await UserModel.refreshUser() ??
              Get.find<AuthSerivce>().currentUser.value;
      Get.back();
      Get.snackbar(
        "145".tr,
        "146".tr,
        backgroundColor: Colors.white,
        icon: const Icon(Icons.notifications),
      );
      Get.forceAppUpdate();
    } else {
      DialogsView.message(
        'Identity Verify',
        response.message,
      ).show();
    }
  }

  Map<String, String> errors = {};
  sendRequset() async {
    if (deliveryStatePrices.isEmpty) {
      errors['delivery_prices'] = 'You must be add delivery prices of states';
      update();
    }
    if (sellerVerifiction.currentState!.validate()) {
      DialogsView.loading().show();
      var response = await mainService.storageDatabase.storageAPI!.request(
        Applink.registerSeller,
        RequestType.post,
        headers: Applink.authedHeaders,
        data: {
          'store_name': nemstore.text,
          'store_address':
              '${slectedCountry.value}->${slectedState.value}->${address.text}',
          'delivery_prices': json.encode({
            for (DeliveryStatePrice deliveryStatePrice
                in deliveryStatePrices.values)
              deliveryStatePrice.state: {
                'office': deliveryStatePrice.officePrice,
                'home': deliveryStatePrice.homePrice,
              }
          })
        },
      );

      Get.back();
      if (response.success) {
        await UserModel.refreshUser();
        Get.snackbar(
          "Register Store",
          "145".tr,
          backgroundColor: Color.fromARGB(255, 149, 250, 168),
        );
        Get.offNamed(
          AppRoute.home,
        );
      } else {
        if (response.errors != null) {
          errors = response.errors!;
          sellerVerifiction.currentState!.validate();
        } else {
          Get.defaultDialog(
            title: "Register store error",
            middleText: response.message,
          );
        }
      }
    }
    update();
  }

  @override
  void onInit() {
    nemstore = TextEditingController();
    address = TextEditingController();
    DefaultAssetBundle.of(Get.context!)
        .loadString("assets/countries.json")
        .then((data) {
      countries = jsonDecode(data);
      // deliveryStates.value = countries["Algeria"]['states'];
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    nemstore.dispose();
    address.dispose();
    super.dispose();
  }
}

class DeliveryStatePrice {
  final String state;
  final double officePrice, homePrice;

  const DeliveryStatePrice(
    this.state,
    this.officePrice,
    this.homePrice,
  );
}
