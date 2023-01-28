import 'dart:io';

import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/controller/controller_add_product.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/core/constant/image_picker.dart';
import 'package:service_electronic/core/services/auth.service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../link_api.dart';
import '../../../widget/network_image.view.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    UserModel user = Get.find<AuthSerivce>().currentUser.value!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 214, 131),
        title: Text(
          Get.arguments?['action'] == 'Edit' ? "Edit Product".tr : "71".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<AddProductController>(
        init: AddProductController(),
        builder: (controller) => controller.statusRequest ==
                StatusRequest.loading
            ? Center(
                child: Lottie.asset(
                  "assets/lottie/loading1.json",
                  height: 80,
                  width: 90,
                ),
              )
            : Container(
                child: user.sellerStatus?.isChecking == true
                    ? Center(
                        child: Column(
                        children: [
                          const Text('Your request is checking'),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Lottie.asset("assets/lottie/jador.json",
                              height: 80, width: 90),
                        ],
                      ))
                    : ListView(
                        children: [
                          Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Image.asset('assets/images/drawer.png'),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 8),
                                        width: w * 0.2,
                                        height: w * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                0, 173, 173, 173),
                                            width: 3,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x68000000),
                                              blurRadius: 5,
                                              offset: Offset(1, 2),
                                            )
                                          ],
                                        ),
                                        child: NetworkImageView(
                                          url: user.image!,
                                          headers: Applink.imageHeaders,
                                          backgroundColor: Colors.blue,
                                          fit: BoxFit.cover,
                                          borderRadius: 50,
                                          setItInDecoration: true,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, right: 5, left: 5),
                                        margin: const EdgeInsets.only(
                                            bottom: 10, right: 10, left: 10),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                106, 0, 0, 0),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Text(
                                          Get.find<AuthSerivce>()
                                                  .currentUser
                                                  .value
                                                  ?.fullname ??
                                              '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Form(
                            key: controller.formstate,
                            onChanged: () {
                              if (controller.errors.isNotEmpty ||
                                  !controller.validateImages) {
                                controller.errors = {};
                                controller.validateImages = true;
                                controller.update();
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: Text(
                                    "37".tr,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  margin: const EdgeInsets.only(
                                      top: 30, left: 30, right: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    border: Border.all(
                                        color: Colors.black, width: 1.5),
                                  ),
                                  child: DropdownButtonFormField<int>(
                                    validator: (value) {
                                      if (value == -1) {
                                        return "اختر احد العناصر ";
                                      } else if (controller.errors
                                          .containsKey('category')) {
                                        return controller.errors['category'];
                                      }
                                    },
                                    items: [
                                      DropdownMenuItem(
                                        value: -1,
                                        child: Text("82".tr),
                                      ),
                                      for (int id in controller.categories.keys)
                                        DropdownMenuItem(
                                          value: id,
                                          child: Text(
                                            controller.categories[id]!.name,
                                          ),
                                        )
                                    ],
                                    onChanged: (val) {
                                      if (val != null) {
                                        controller.changeModel(val);
                                      }
                                    },
                                    value: controller.selctedmodel.value,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 30, right: 30),
                                  child: myTextFormField(
                                    mycontroller: controller.name,
                                    valid: (v) {
                                      if (v!.isEmpty) {
                                        return "18".tr;
                                      } else if (controller.errors
                                          .containsKey('name')) {
                                        return controller.errors['name'];
                                      }
                                    },
                                    labeltext: "78".tr,
                                    iconData: Icons.shopping_bag_outlined,
                                    hintText: "79".tr,
                                    enabled: true,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 30, right: 30),
                                  child: myTextFormField(
                                    mycontroller: controller.price,
                                    valid: (v) {
                                      if (v!.isEmpty) {
                                        return "18".tr;
                                      } else if (controller.errors
                                          .containsKey('price')) {
                                        return controller.errors['price'];
                                      }
                                    },
                                    labeltext: "39".tr,
                                    iconData: Icons.price_change_outlined,
                                    hintText: "74".tr,
                                    isNumber: true,
                                    enabled: true,
                                    onChanged: controller.onPriceChange,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 50, right: 30),
                                  child: Text(
                                    "${"124".tr} ${user.platformSettings.commisstion}% \n${"36".tr} ${controller.totalPrice} DZD",
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: myTextFormField(
                                    mycontroller: controller.count,
                                    valid: (v) {
                                      if (v!.isEmpty) {
                                        return "18".tr;
                                      } else if ((int.tryParse(v) ?? 0) <= 0) {
                                        return "18".tr;
                                      } else if (controller.errors
                                          .containsKey('count')) {
                                        return controller.errors['count'];
                                      }
                                    },
                                    labeltext: "142".tr,
                                    iconData: Icons.numbers,
                                    hintText: "142".tr,
                                    textType: TextInputType.number,
                                    enabled: true,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 30, right: 30, bottom: 20),
                                  child: TextFormField(
                                    controller: controller.description,
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return "الحقل فارغ";
                                      } else if (controller.errors
                                          .containsKey('description')) {
                                        return controller.errors['description'];
                                      }
                                    },
                                    maxLines: 10,
                                    maxLength: 300,
                                    decoration: InputDecoration(
                                      labelText: "75".tr,
                                      labelStyle: const TextStyle(
                                        fontSize: 20,
                                      ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                ),
                                Text(
                                  "77".tr,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  color:
                                      const Color.fromARGB(255, 190, 189, 189),
                                  width: w * 0.8,
                                  height: h * 0.25,
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: controller.pickImages,
                                        child: const Text('select images'),
                                      ),
                                      Flexible(
                                        child: ListView.builder(
                                          itemCount: controller.images.length,
                                          itemBuilder: (context, index) {
                                            File file =
                                                controller.images[index];
                                            return ListTile(
                                              leading: Image.file(file),
                                              subtitle: Text(
                                                  '${(file.lengthSync() / 1024).toStringAsFixed(2)} KB'),
                                              onTap: () {
                                                Get.to(
                                                  ImagePreview(
                                                    image: file,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if (!controller.validateImages ||
                                    controller.errors.containsKey('images'))
                                  Text(
                                    controller.errors['images'] ??
                                        'Please chose images',
                                    style: const TextStyle(
                                        color: Colors.redAccent),
                                  ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 30, bottom: 50),
                                  child: myMaterialButton(
                                    color: const Color.fromARGB(
                                        255, 149, 244, 152),
                                    onPressed: controller.action == 'Edit'
                                        ? controller.editProduct
                                        : controller.fancation,
                                    text: "52".tr,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }
}
