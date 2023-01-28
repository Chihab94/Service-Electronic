import 'dart:io';

import 'package:service_electronic/Data/datasores/contries.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:service_electronic/view/screen/the_seller/controller_seller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/class/statusRequest.dart';

class Seller2 extends StatelessWidget {
  const Seller2({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<SellerController>(
      init: SellerController(),
      builder: (controller) {
        return  Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 8, 8, 8),
                  title: Center(
                    child: Text(
                      "129".tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                body: Container(
                  child: ListView(
                    children: [
                      SizedBox(height: h * 0.04),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              height: h * 0.3,
                              margin: const EdgeInsets.all(5),
                              color: Colors.blue,
                              child: InkWell(
                                onTap: () {
                                  //ToDo: for product
                                  controller.ublodimage();
                                },
                                child: Image(
                                  image: controller.imageverification != null
                                      ? FileImage(controller.imageverification!)
                                          as ImageProvider
                                      : const AssetImage(
                                          "assets/images/howiya.png",
                                        ),
                                ),
                              ),
                            ),
                            if (controller.showValidate &&
                                controller.imageverification == null)
                              Text(
                                'Please chose your identity image'.tr,
                                style: const TextStyle(color: Colors.red),
                              ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: ListTile(
                                title: Text("131".tr),
                              ),
                            ),
                            Container(
                              height: h * 0.3,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                color: Colors.blue,
                                child: InkWell(
                                  onTap: () {
                                    //ToDo: for product
                                    controller.ublodimageaddress();
                                  },
                                  child: Image(
                                    image: controller.imageaddress != null
                                        ? FileImage(controller.imageaddress!)
                                            as ImageProvider
                                        : const AssetImage(
                                            "assets/images/uplod.png"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (controller.showValidate &&
                          controller.imageaddress == null)
                        Text(
                          'Please chose your address image'.tr,
                          style: const TextStyle(color: Colors.red),
                        ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 30, left: 40, right: 40),
                        child: myMaterialButton(
                          onPressed: controller.verifiyIdentity,
                          text: "127".tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                          color: Colors.black,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
