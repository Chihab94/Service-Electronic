import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';
import '../view/widget/dialogs.view.dart';
import 'controller_solide.dart';

class SettingsController extends GetxController {
  MainService mainService = Get.find();
  AuthSerivce authSerivce = Get.find<AuthSerivce>();

  StatusRequest statusRequest = StatusRequest.success;

  UserModel user = Get.find<AuthSerivce>().currentUser.value!;

  editImage() async {
    statusRequest = StatusRequest.loading;
    update();
    XFile? imageprofiel =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageprofiel != null) {
      APIResponse response = await user.updateImageProfile(
          await FlutterNativeImage.compressImage(imageprofiel.path,
              quality: 15));
      statusRequest = StatusRequest.success;
      update();
      DialogsView.message('Edit Image Profile', response.message).show();
    }
  }

  editEmail() {
    TextEditingController emailController = TextEditingController();
    DialogsView.form(
      title: 'Edit settings ',
      fields: [
        DialogFormField(
          name: 'email',
          controller: emailController,
          sefix: Icons.email_outlined,
        ),
      ],
      onSubmit: (fields) async {
        statusRequest = StatusRequest.loading;
        update();
        APIResponse res = await mainService.storageDatabase.storageAPI!.request(
          'auth/change_email',
          RequestType.post,
          headers: Applink.authedHeaders,
          data: {
            'new_email': fields[0].controller.text,
          },
        );
        if (res.success && res.value != null) {
          authSerivce.signout();
        } else {
          statusRequest = StatusRequest.success;
          update();
          DialogsView.message(
            'Edit Settings',
            res.message,
          ).show();
        }
      },
      onCancel: () async {},
    ).show();
  }

  editPassword() {
    TextEditingController passwordController = TextEditingController();
    DialogsView.form(
      title: 'Edit settings ',
      fields: [
        DialogFormField(
          name: 'Password',
          controller: passwordController,
          sefix: Icons.password_outlined,
          type: TextInputType.visiblePassword,
        ),
      ],
      onSubmit: (fields) async {
        statusRequest = StatusRequest.loading;
        update();
        APIResponse res = await mainService.storageDatabase.storageAPI!.request(
          'auth/rp_check_password',
          RequestType.post,
          headers: Applink.authedHeaders,
          data: {
            'password': fields[0].controller.text,
          },
        );
        if (res.success && res.value != null) {
          authSerivce.signout();
        } else {
          statusRequest = StatusRequest.success;
          update();
          DialogsView.message(
            'Edit Settings',
            res.message,
          ).show();
        }
      },
      onCancel: () async {},
    ).show();
  }

  setter() {
    Get.toNamed(AppRoute.seller);
  }
}
