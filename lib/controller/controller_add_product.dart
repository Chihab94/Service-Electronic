import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:service_electronic/Data/model/category.model.dart';
import 'package:service_electronic/Data/model/product.model.dart';
import 'package:service_electronic/core/class/statusRequest.dart';

import 'package:service_electronic/core/services/main.service.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/view/widget/dialogs.view.dart';
import 'package:storage_database/api/response.dart';
import '../Data/model/user.mode.dart';
import '../core/services/auth.service.dart';

class AddProductController extends GetxController {
  UserModel user = Get.find<AuthSerivce>().currentUser.value!;
  Map<int, CategoryModel> categories = {};

  String action = 'Add';
  ProductModel? oldProudct;
  bool imagesEdited = false;

  var isProficPicpathset = false.obs;
  RxList<File> images = <File>[].obs;
  bool validateImages = true;
  //======== خاصة بصور المنتجات ======================

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController price;
  late TextEditingController count;
  double totalPrice = 0;
  RxInt selctedmodel = (-1).obs;

  Map<String, String> errors = {};

  // ============== سطر خاص حفظ البيانات شرد برفرنس =================
  MainService myService = Get.find();
  StatusRequest statusRequest = StatusRequest.loading;

  onPriceChange(String text) {
    totalPrice = (double.tryParse(text) ?? 0) +
        ((double.tryParse(text) ?? 0) * user.platformSettings.commisstion);
    update();
  }

  // =================== فنكشن رفع صور المنتجات ======================================

  comporessImages(List<XFile> images) async {
    for (XFile image in images) {
      try {
        this.images.add((File(image.path).lengthSync() / 2048) > 2
            ? await FlutterNativeImage.compressImage(image.path, quality: 20)
            : File(image.path));
      } catch (e) {
        print(e);
      }
    }
  }

  pickImages() async {
    if (action == 'Edit' && !imagesEdited) {
      images.clear();
      imagesEdited = true;
    }
    List<XFile> image = await ImagePicker().pickMultiImage();
    if (image.isNotEmpty) {
      await comporessImages(image);
      update();
    }
    update();
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    price.dispose();
    count.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    name = TextEditingController();
    description = TextEditingController();
    price = TextEditingController();
    count = TextEditingController();
    CategoryModel.loadAll().then((items) async {
      categories = {
        for (CategoryModel category in items) category.id: category,
      };
      Map? args = Get.arguments;
      if (args != null &&
          args['action'] == 'Edit' &&
          args.containsKey('product')) {
        action = 'Edit';
        oldProudct = args['product'];
        name.text = oldProudct!.name;
        description.text = oldProudct!.description;
        count.text = oldProudct!.count.toString();
        selctedmodel.value = oldProudct!.category.id;

        for (String url in oldProudct!.imagesUrils) {
          File? image = (await Get.find<MainService>()
                  .storageDatabase
                  .explorer!
                  .networkFiles!
                  .file(
                    url,
                    headers: Applink.imageHeaders,
                  ))
              ?.ioFile;
          if (image != null) images.add(image);
        }
      }
      statusRequest = StatusRequest.success;
      update();
    });

    super.onInit();
  }

  void changeModel(int value) {
    selctedmodel.value = value;
    update();
  }

//================ فنكشن رفع الصور ===============================================

  fancation() async {
    validateImages = images.isNotEmpty;
    update();
    if (formstate.currentState!.validate() && validateImages) {
      DialogsView.loading().show();
      var response = await ProductModel.create(
        category: categories[selctedmodel.value]!,
        name: name.text,
        price: double.parse(price.text),
        count: int.parse(count.text),
        description: description.text,
        images: images,
      );
      Get.back();
      if (response.success) {
        Get.back();
      } else {
        if (response.errors != null) {
          errors = response.errors!;
          formstate.currentState!.validate();
        } else {
          DialogsView.message(
            'Edit Product Error',
            response.message,
          ).show();
        }
      }
    }
  }

  editProduct() async {
    if (formstate.currentState!.validate()) {
      DialogsView.loading().show();
      oldProudct!.name = name.text;
      oldProudct!.description = description.text;
      oldProudct!.count = int.parse(count.text);
      oldProudct!.price = double.parse(price.text);
      oldProudct!.category = categories[selctedmodel.value]!;
      APIResponse response = await oldProudct!.save(
        newImages: imagesEdited && images.isNotEmpty ? images : null,
      );
      Get.back();
      if (response.success) {
        Get.back();
      } else {
        if (response.errors != null) {
          errors = response.errors!;
          formstate.currentState!.validate();
        } else {
          DialogsView.message(
            'Edit Product Error',
            response.message,
          ).show();
        }
      }
    }
  }
}
