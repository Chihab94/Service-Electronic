import 'dart:io';

import 'package:flutter/services.dart';
import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/routes.dart';
import 'package:service_electronic/view/screen/Shipping/Pay_controller.dart';
import 'package:service_electronic/view/widget/dialogs.view.dart';
import 'package:service_electronic/view/widget/dropdown.view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../Data/model/user.mode.dart';
import '../../../core/class/statusRequest.dart';
import '../../../core/services/auth.service.dart';

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    UserModel user = Get.find<AuthSerivce>().currentUser.value!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("132".tr)),
      ),
      body: GetBuilder<PayController>(
        init: PayController(),
        builder: (controller) {
          return controller.statusRequest == StatusRequest.loading
              ? Center(
                  child: Lottie.asset("assets/lottie/jador.json",
                      height: 300, width: 200),
                )
              : RefreshIndicator(
                  onRefresh: controller.refreshPage,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Form(
                      key: controller.protfolio,
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(248, 105, 250, 134),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black87,
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Text(
                                  "${user.balance.toStringAsFixed(2)} DZD",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 17, 17, 17)),
                                ),
                              ),
                              if (controller.display != 3)
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: const Text(
                                      "≈",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    )),
                              if (controller.display != 3)
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(248, 105, 250, 134),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black87,
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Text(
                                    controller.display == 1
                                        ? "${(controller.user.balance * double.parse(user.platformSettings.platformCurrency.dPrices[user.platformSettings.displayCurrency.id.toString()]['buy'].toString())).toStringAsFixed(3)} ${user.platformSettings.displayCurrency.char}"
                                        : "${(controller.user.balance * double.parse(user.platformSettings.platformCurrency.dPrices[user.platformSettings.displayCurrency.id.toString()]['sell'].toString())).toStringAsFixed(3)} ${user.platformSettings.displayCurrency.char}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 17, 17, 17)),
                                  ),
                                ),
                              const Expanded(child: SizedBox()),
                              InkWell(
                                onTap: () {
                                  controller.historque();
                                },
                                child: const Icon(
                                  Icons.summarize,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                "136".tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color.fromARGB(235, 10, 10, 10)),
                              ),
                              Text(
                                "${user.balance} DZD",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color.fromARGB(235, 10, 10, 10)),
                              ),
                              const Icon(
                                Icons.remove_red_eye,
                                size: 20,
                              )
                            ],
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: w * 0.3,
                                height: h * 0.065,
                                child: myMaterialButton(
                                  color: Color.fromARGB(255, 236, 255, 64),
                                  onPressed: () {
                                    controller.display = 1;
                                    controller.update();
                                  },
                                  text: "133".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color.fromARGB(236, 12, 12, 12)),
                                ),
                              ),
                              Container(
                                width: w * 0.3,
                                height: h * 0.065,
                                child: myMaterialButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    controller.display = 2;
                                    controller.update();
                                  },
                                  text: "134".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Color.fromARGB(236, 12, 12, 12)),
                                ),
                              ),
                              Container(
                                width: w * 0.3,
                                height: h * 0.065,
                                child: myMaterialButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    controller.display = 3;
                                    controller.update();
                                  },
                                  text: "135".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Color.fromARGB(235, 10, 10, 10)),
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 3),
                          if (controller.display != 3)
                            DropDownView<int>(
                              value: controller.currenctCurrencyId,
                              margin:
                                  const EdgeInsets.only(right: 40, left: 40),
                              borderRadius: BorderRadius.circular(15),
                              items: [
                                DropdownMenuItem(
                                  value: -1,
                                  child: Text('Pay Currency'),
                                ),
                                for (CurrencyModel currency
                                    in controller.platofromCurrencies.values)
                                  DropdownMenuItem(
                                    value: currency.id,
                                    child: Text(
                                        '${currency.name} (${currency.char})'),
                                  ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  controller.currenctCurrencyId = value;
                                  controller.blanci.clear();
                                  controller.dibosit.clear();
                                  controller.rechargeBalance = 0;
                                  controller.sellBalance = 0;
                                  controller.update();
                                }
                              },
                            ),
                          Gap(15),

                          //========== Dibosit ===================================
                          if (controller.display == 1)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (controller.currenctCurrencyId != -1)
                                  for (String item in controller
                                      .platofromCurrencies[
                                          controller.currenctCurrencyId]!
                                      .wallet)
                                    Container(
                                      width: w * 0.8,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      color: const Color.fromARGB(
                                          253, 201, 253, 203),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            item,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Expanded(child: Gap(2)),
                                          InkWell(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                  text: item,
                                                ));
                                                Get.snackbar('162'.tr, '161'.tr,
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 211, 249, 213),
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 100,
                                                        horizontal: 20),
                                                    icon:
                                                        const Icon(Icons.copy));
                                              },
                                              child: const Icon(
                                                Icons.layers,
                                                size: 25,
                                                color: Colors.black,
                                              ))
                                        ],
                                      ),
                                    ),
                                  const Gap(10),
                                if (controller.currenctCurrencyId != -1)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 40,
                                        left: 40,
                                        top: 10,
                                        bottom: 5),
                                    child: myTextFormField(
                                      enabled: true,
                                      isNumber: true,
                                      mycontroller: controller.dibosit,
                                      onChanged:
                                          controller.calculateRechareBalance,
                                      valid: (v) {
                                        if (v!.isEmpty) {
                                          return "18".tr;
                                        }
                                      },
                                      labeltext: "30".tr,
                                      iconData: Icons.money,
                                      hintText:
                                          "${controller.currenctCurrencyId != -1 ? controller.platofromCurrencies[controller.currenctCurrencyId]!.char : ""}  ${"39".tr}",
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                Center(
                                  child: Text(
                                    '${controller.rechargeBalance.toStringAsFixed(3)} ${controller.user.platformSettings.platformCurrency.char} ${"29".tr}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text("138".tr),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, bottom: 50, right: 30, left: 30),
                                  color: const Color.fromARGB(255, 8, 8, 8),
                                  height: h * 0.3,
                                  width: w * 1,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    color: Colors.blue,
                                    child: InkWell(
                                        onTap: () {
                                          //ToDo: for product
                                          controller.ublodimage();
                                        },
                                        child: Image(
                                          image: controller.imageproof != null
                                              ? FileImage(
                                                      controller.imageproof!)
                                                  as ImageProvider
                                              : const AssetImage(
                                                  "assets/images/uplod.png"),
                                        )),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: h * 0.085,
                                    child: myMaterialButton(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      color: Color.fromARGB(255, 7, 7, 7),
                                      onPressed: () {
                                        controller.dibosi();
                                      },
                                      text: "16".tr,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          //=========== withdraw ======================================
                          if (controller.display == 2)
                            Container(
                              child: Column(
                                children: [
                                  if (controller.currenctCurrencyId != -1)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 40,
                                          left: 40,
                                          top: 5,
                                          bottom: 0),
                                      child: myTextFormField(
                                        enabled: true,
                                        isNumber: true,
                                        mycontroller: controller.blanci,
                                        valid: (v) {
                                          if (v!.isEmpty) {
                                            return "18".tr;
                                          } else if (controller.sellBalance >
                                              controller.user.balance) {
                                            return "148".tr;
                                          }
                                        },
                                        onChanged: controller.calculateBalance,
                                        labeltext: "142".tr,
                                        iconData: Icons.money,
                                        hintText:
                                            "${controller.currenctCurrencyId != -1 ? controller.platofromCurrencies[controller.currenctCurrencyId]!.char : ""}  ${"39".tr}",
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                    ),
                                  Text(
                                    '${controller.sellBalance.toStringAsFixed(3)} ${controller.user.platformSettings.platformCurrency.char} ${"29".tr}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Gap(10),
                                  Text(
                                    "140".tr,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 20,
                                        right: 20,
                                        bottom: 20),
                                    child: TextFormField(
                                      controller: controller.withdraw,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "الحقل فارغ";
                                        }
                                      },
                                      maxLines: null,
                                      maxLength: 250,
                                      decoration: InputDecoration(
                                        hintText: "139".tr,
                                        suffixIcon:
                                            const Icon(Icons.history_edu),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      height: h * 0.085,
                                      child: myMaterialButton(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        color: Color.fromARGB(255, 7, 7, 7),
                                        onPressed: () {
                                          controller.Withdraw();
                                        },
                                        text: "16".tr,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          //============== transfer ================================
                          if (controller.display == 3)
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 40,
                                      left: 40,
                                      top: 20,
                                    ),
                                    child: myTextFormField(
                                      enabled: true,
                                      isNumber: true,
                                      mycontroller: controller.blanci,
                                      valid: (value) {
                                        if (value!.isEmpty) {
                                          return "18".tr;
                                        } else if ((double.tryParse(value) ??
                                                0) >
                                            controller.user.balance) {
                                          return "148".tr;
                                        }
                                      },
                                      labeltext: "142".tr,
                                      iconData: Icons.money,
                                      hintText: "39".tr,
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                  Gap(5),
                                  Text(
                                    "141".tr,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 20,
                                        left: 20,
                                        top: 20,
                                        bottom: 5),
                                    child: myTextFormField(
                                      enabled: true,
                                      isNumber: false,
                                      mycontroller: controller.transfier,
                                      valid: (v) {
                                        if (v!.isEmpty) {
                                          return "18".tr;
                                        }
                                      },
                                      labeltext: "135".tr,
                                      iconData: Icons.email_outlined,
                                      hintText: "2.5".tr,
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.05,
                                  ),
                                  Center(
                                    child: Container(
                                      height: h * 0.085,
                                      child: myMaterialButton(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        color: Color.fromARGB(255, 7, 7, 7),
                                        onPressed: () {
                                          controller.transfer();
                                        },
                                        text: "16".tr,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          //
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
