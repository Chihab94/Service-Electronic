import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:service_electronic/controller/controller_solide.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:service_electronic/view/screen/screen_home/screen_echange/exchange_2.controller.dart';

import '../../../../core/class/statusRequest.dart';
import '../../../../core/localization/localiztioncontroller.dart';

class echonge_2 extends StatelessWidget {
  const echonge_2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<Exchone2Controller>(
      init: Exchone2Controller(),
      builder: (controller) {
        String lang = Get.find<LocaleController>().language.languageCode;
        return Scaffold(
          //appBar: AppBar(backgroundColor: Colors.blue,),
          body: controller.statusRequest.value == StatusRequest.loading
              ? Center(
                  child: Lottie.asset("assets/lottie/loading1.json",
                      height: 80, width: 90),
                )
              : Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          InkWell(
                            onTap: () => Get.back(),
                            child: const Text(
                              " ×",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 80),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15, right: 5, left: 5),
                            child: Form(
                              key: controller.Confirm,
                              child: Column(
                                children: [
                                  Row(children: [
                                    FittedBox(
                                      child: Text(
                                        "66".tr,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ]),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: FittedBox(
                                              child: Text(
                                                controller.sendedCurrency.name,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: FittedBox(
                                                child: Text(
                                                    controller.receivedBalance
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 249, 3, 3))))),
                                        FittedBox(
                                            child: Text(
                                                controller.sendedCurrency.char,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 247, 4, 4)))),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: const Icon(
                                            Icons.change_circle,
                                            color: Colors.orangeAccent,
                                            size: 30,
                                          ),
                                        ),
                                        Center(
                                          child: FittedBox(
                                            child: Text(
                                              controller.receivedCurrency.name,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: FittedBox(
                                                child: Text(
                                              controller.sendedBalance
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 2, 152, 7)),
                                            ))),
                                        FittedBox(
                                            child: Text(
                                          controller.receivedCurrency.char,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 0, 170, 6)),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 5,
                                  ),
                                  if (controller.sendedCurrency.id !=
                                      controller.user.platformSettings
                                          .platformCurrency.id) ...[
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    for (String item
                                        in controller.sendedCurrency.wallet)
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 20, left: 20),
                                        margin: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        color: const Color.fromARGB(
                                            255, 223, 227, 225),
                                        height: h * 0.06,
                                        width: w * 0.8,
                                        child: Row(
                                          children: [
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Expanded(child: Gap(2)),
                                            InkWell(
                                                onTap: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                    text: item,
                                                  ));
                                                  Get.snackbar(
                                                    '162'.tr,
                                                    '161'.tr,
                                                    backgroundColor:Color.fromARGB(255, 211, 249, 213),
                                                    margin:const EdgeInsets.symmetric(vertical: 100,horizontal: 20),
                                                    icon:const Icon(Icons.copy)
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.layers,
                                                  size: 25,
                                                  color: Colors.black,
                                                ))
                                          ],
                                        ),
                                      ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                  ],
                                  for (var name
                                      in controller.sendedCurrency.data.keys)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 40,
                                          left: 40,
                                          top: 10,
                                          bottom: 5),
                                      child: myTextFormField(
                                        enabled: true,
                                        isNumber: true,
                                        mycontroller:
                                            controller.dataControllers[name],
                                        labeltext: controller.sendedCurrency
                                            .data[name]['title_$lang'],
                                        hintText: "",
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                    ),
                                  const Gap(10),
                                  if (controller.sendedCurrency.id !=
                                          controller.user.platformSettings
                                              .platformCurrency.id &&
                                      controller
                                          .sendedCurrency.proofIsRequired) ...[
                                    Text("138".tr),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 50,
                                        right: 20,
                                        left: 20,
                                      ),
                                      color: const Color.fromARGB(255, 8, 8, 8),
                                      height: h * 0.3,
                                      width: w * 1,
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        color: Colors.blue,
                                        child: InkWell(
                                          onTap: controller.ublodimage,
                                          child: Image(
                                            image: controller.imageproof != null
                                                ? FileImage(
                                                        controller.imageproof!)
                                                    as ImageProvider
                                                : const AssetImage(
                                                    "assets/images/uplod.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  Container(
                                    height: h * 0.085,
                                    child: myMaterialButton(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      color: Colors.blue,
                                      onPressed: controller.Confirme,
                                      text: "52".tr,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
