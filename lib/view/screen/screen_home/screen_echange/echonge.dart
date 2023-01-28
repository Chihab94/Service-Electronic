import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/controller/controller_solide.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/core/constant/solide.dart';
import 'package:service_electronic/core/services/notifiction.service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../controller/controller_solide.dart';
import '../../../../core/class/statusRequest.dart';
import '../../../../core/constant/circleraviter.dart';
import '../../../../core/constant/icon_Bottun.dart';
import 'controller_Sella.dart';

class MyEchonge extends StatelessWidget {
  const MyEchonge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text(
              "8".tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            GetBuilder<TransfersController>(
                init: TransfersController(),
                builder: (controller) {
                  return MyIconBottun(
                    count: controller.transfers.fold(
                        0,
                        (value, transfer) =>
                            value + (transfer.status.isChecking ? 1 : 0)),
                    radius: 10,
                    onTap: () {
                      controller.chongenotification();
                    },
                    icon: Icons.shopping_cart_outlined,
                    backgroundColor: Colors.red,
                  );
                }),
            const mycircleraviter(
              image: "assets/images/logo3.png",
              minRadius: 5,
              maxRadius: 23,
              height: 50,
              width: 50,
              backgroundColor: Colors.white,
            ),
          ]),
      body: GetBuilder<MyEchongeController>(
          init: MyEchongeController(),
          builder: (controller) {
            return controller.statusRequest.value == StatusRequest.loading
                ? Center(
                    child: Lottie.asset("assets/lottie/loading1.json",
                        height: 80, width: 90),
                  )
                : RefreshIndicator(
                    onRefresh: controller.refreshPage,
                    child: Form(
                      key: controller.solidFormKey,
                      child: ListView(children: [
                        Row(
                          children: [
                            Expanded(
                              child: GetBuilder<MyEchongeController>(
                                init: MyEchongeController(),
                                builder: (controller) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Center(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, bottom: 10),
                                          child: Text(
                                            "40".tr,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      // send
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: controller.solid.length,
                                        itemBuilder: (context, index) {
                                          return MySolide(
                                            onPressed: () {
                                              controller.from.value = index;
                                              controller.to.value = -1;
                                              controller.send.clear();
                                              controller.resevied.clear();
                                              controller.update();
                                            },
                                            isSelected:
                                                controller.from.value == index,
                                            currency: controller.solid[index],
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            if (controller.from.value != -1)
                              Expanded(
                                child: GetBuilder<MyEchongeController>(
                                  init: MyEchongeController(),
                                  builder: (controller) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Center(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 20,
                                              bottom: 10,
                                            ),
                                            child: Text(
                                              "41".tr,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        //recive
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: controller.solidTo.length,
                                          itemBuilder: (context, index) {
                                            return MySolide(
                                              onPressed:
                                                  controller.from.value != -1
                                                      ? () {
                                                          controller.to.value =
                                                              index;
                                                          controller.update();
                                                          controller.send
                                                              .clear();
                                                          controller.resevied
                                                              .clear();
                                                        }
                                                      : null,
                                              isSelected:
                                                  controller.to.value == index,
                                              currency:
                                                  controller.solidTo[index],
                                              showMax: controller
                                                      .user
                                                      .platformSettings
                                                      .platformCurrency
                                                      .id ==
                                                  controller.solidTo[index].id,
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 50, right: 50, top: 50),
                          child: Column(
                            children: [
                              GetBuilder<MyEchongeController>(
                                  builder: (controller) {
                                return Text(
                                  controller.from.value != -1
                                      ? controller
                                          .solid[controller.from.value].name
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                );
                              }),
                              const Icon(
                                Icons.arrow_circle_up_outlined,
                                color: Colors.green,
                              ),
                              const Gap(5),
                              GetBuilder<MyEchongeController>(
                                  builder: (controller) {
                                return myTextFormField(
                                  textType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  mycontroller: controller.send,
                                  onChanged: controller.calculateSend,
                                  valid: (value) {
                                    if (controller.from.value == -1) {
                                      return "68".tr;
                                    } else if (value!.isEmpty) {
                                      return '18'.tr;
                                    } else if (double.parse(value) <= 10) {
                                      return "47".tr;
                                    } else if (double.parse(value) >
                                        controller.solid[controller.from.value]
                                            .maxReceive) {
                                      return "48".tr;
                                    } else if (double.parse(value) <= 10) {
                                      return "47".tr;
                                    }
                                  },
                                  labeltext: "29".tr,
                                  iconData: Icons.currency_exchange,
                                  hintText:
                                      "${controller.from.value != -1 ? controller.solid[controller.from.value].char : ""} ${"39".tr}",
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabled: true,
                                );
                              }),
                              GetBuilder<MyEchongeController>(
                                  builder: (controller) {
                                return Text(
                                  controller.to.value != -1
                                      ? controller
                                          .solidTo[controller.to.value].name
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                );
                              }),
                              const Icon(
                                Icons.arrow_circle_down_sharp,
                                color: Colors.blue,
                              ),
                              const Gap(5),
                              GetBuilder<MyEchongeController>(
                                  init: MyEchongeController(),
                                  builder: (controller) {
                                    return myTextFormField(
                                      enabled: true,
                                      isNumber: true,
                                      mycontroller: controller.resevied,
                                      onChanged: controller.calculateReceived,
                                      valid: (value) {
                                        if (controller.to.value == -1) {
                                          return '69'.tr;
                                        } else if (value!.isEmpty) {
                                          return '18'.tr;
                                        } else if (controller
                                                    .user
                                                    .platformSettings
                                                    .platformCurrency
                                                    .id ==
                                                controller
                                                    .solidTo[
                                                        controller.to.value]
                                                    .id &&
                                            double.parse(value) >
                                                controller.user.balance) {
                                          return '148'.tr;
                                        } else if (double.parse(value) <= 10) {
                                          return '47'.tr;
                                        }
                                      },
                                      labeltext: "30".tr,
                                      iconData: Icons.currency_exchange,
                                      hintText:
                                          "${controller.to.value != -1 ? controller.solidTo[controller.to.value].char : ""} ${"39".tr}",
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    );
                                  }),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              SizedBox(
                                height: h * 0.06,
                              ),
                              Container(
                                height: h * 0.085,
                                child: myMaterialButton(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.blue,
                                    onPressed: () {
                                      controller.reservation();
                                    },
                                    text: "38".tr),
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  );
          }),
    );
  }
}
