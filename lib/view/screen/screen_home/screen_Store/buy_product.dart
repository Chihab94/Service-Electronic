import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/core/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/controller_Store.dart';
import '../../../../core/class/statusRequest.dart';
import '../../../../core/constant/bottun.dart';

class Store2 extends StatelessWidget {
  const Store2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<StoreController>(
        init: StoreController(),
        builder: (controller) {
          return Material(
            child: controller.statusRequest == StatusRequest.loading
                ? Center(
                    child: Lottie.asset("assets/lottie/loading1.json",
                        height: 80, width: 90),
                  )
                : Scaffold(
                    appBar: AppBar(
                      backgroundColor:const Color.fromARGB(255, 59, 214, 131),
                      title:  Text(
                          "11".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      
                    ),
                    body: SizedBox(
                      height: h,
                      width: w,
                      child: Form(
                        key: controller.formstore2,
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20, left: 20, top: 50, bottom: 15),
                              child: myTextFormField(
                                enabled: true,
                                mycontroller: controller.fullname,
                                valid: (v) {},
                                labeltext: "19.5".tr,
                                iconData: Icons.person,
                                hintText: "20".tr,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20, left: 20, top: 20, bottom: 5),
                              child: myTextFormField(
                                enabled: true,
                                mycontroller: controller.phone,
                                valid: (v) {},
                                labeltext: "15".tr,
                                iconData: Icons.phone_android,
                                hintText: "113".tr,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20, left: 20, top: 20, bottom: 5),
                              child: myTextFormField(
                                enabled: true,
                                isNumber: true,
                                mycontroller: controller.count,
                                valid: (v) {
                                  if (v == null || (int.tryParse(v) ?? 0) < 1) {
                                    return "count must be not 0";
                                  }
                                },
                                labeltext: "142".tr,
                                iconData: Icons.numbers,
                                hintText: "142".tr,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              margin: const EdgeInsets.only(
                                  top: 30, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                              ),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == '-1') {
                                    return "اختر احد العناصر ";
                                  }
                                },
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: '-1',
                                    child: Text("117".tr),
                                  ),
                                  for (String state in controller
                                      .currenctProduct!
                                      .seller
                                      .deliveryPrices
                                      .keys)
                                    DropdownMenuItem(
                                      value: state,
                                      child: Text(
                                        state,
                                      ),
                                    )
                                ],
                                onChanged: (val) {
                                  if (val != null) controller.changeState(val);
                                },
                                value: controller.slectedState.value,
                              ),
                            ),
                            if (controller.slectedState.value != '-1') ...[
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                margin: const EdgeInsets.only(
                                    top: 30, left: 25, right: 25),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                ),
                                child: DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (value == '-1') {
                                      return "اختر احد العناصر ";
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: '-1',
                                      child: Text("120".tr),
                                    ),
                                    DropdownMenuItem(
                                      value: 'office',
                                      child: Text('119'.tr),
                                    ),
                                    DropdownMenuItem(
                                      value: 'home',
                                      child: Text('118'.tr),
                                    )
                                  ],
                                  onChanged: (val) {
                                    if (val != null)
                                      controller.changeDeliveryType(val);
                                  },
                                  value: controller.deliveryType,
                                ),
                              ),
                              if (controller.deliveryType == 'home')
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 20, top: 20, bottom: 15),
                                  child: myTextFormField(
                                    enabled: true,
                                    mycontroller: controller.street,
                                    valid: (v) {
                                      if (controller.deliveryType == 'home' &&
                                          v!.isEmpty) {
                                        return '18'.tr;
                                      }
                                    },
                                    labeltext: "114".tr,
                                    iconData: Icons.location_on,
                                    iconcolor: Colors.red,
                                    hintText: "115".tr,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                            ],
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: w * 0.85,
                                        child: FittedBox(
                                          child: Text(
                                            '${'121'.tr} : ${controller.currenctProduct?.price} DZD + ${controller.delveryPrice} DZD = ${controller.totalPrice} DZD',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.account_balance_wallet,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      Text(
                                        '${'122'.tr} : ${Get.find<AuthSerivce>().currentUser.value!.balance} DZD',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                const  Gap(5),
                                  if (controller.balanceInvalid)
                                    Text('148'.tr,style:const TextStyle(color: Colors.red),)
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 30, right: 30, top: 30, bottom: 50),
                                child: myMaterialButton(
                                  color:const Color.fromARGB(255, 59, 214, 131),
                                  onPressed: controller.buyProduct,
                                  text: "52".tr,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
