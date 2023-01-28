import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/link_api.dart';

import 'package:service_electronic/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/view/widget/dialogs.view.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';

class signupController extends GetxController {
  MainService myService = Get.find();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController firsetnem;
  late TextEditingController lastnem;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController Confirmpassword;

  Map<String, String> errors = {};

  signup() async {
    if (formstate.currentState!.validate()) {
      // update();
      DialogsView.loading().show();
      try {
        APIResponse signupResponse =
            await myService.storageDatabase.storageAPI!.request(
          Applink.singup,
          RequestType.post,
          headers: Applink.headers,
          data: {
            'firstname': firsetnem.text,
            'lastname': lastnem.text,
            'email': email.text,
            'phone': phone.text,
            'password': password.text,
            'messaging_token': await FirebaseMessaging.instance.getToken()
          },
          log: true,
        );

        if (signupResponse.success && signupResponse.value != null) {
          Get.offNamed(
            AppRoute.VerificodeSingup,
            arguments: signupResponse.value,
          );
        } else {
          Get.back();
          if (signupResponse.errors != null) {
            errors = signupResponse.errors!;
            update();
            formstate.currentState!.validate();
          } else {
            Get.defaultDialog(
              title: "Signup error",
              middleText: signupResponse.message,
            );
          }
        }
      } catch (e) {
        Get.back();
        Get.defaultDialog(
          title: "Signup error",
          middleText: "Some things worng",
        );
      }
    }
  }

  @override
  void onInit() {
    firsetnem = TextEditingController();
    lastnem = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    Confirmpassword = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    firsetnem.dispose();
    lastnem.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    Confirmpassword.dispose();
    super.dispose();
  }
}
