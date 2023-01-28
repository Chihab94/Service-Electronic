import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/Data/model/transfer.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/core/services/main.service.dart';

import '../../../../Data/model/exchange.model.dart';
import '../../../../core/class/statusRequest.dart';

class HomeCart extends StatelessWidget {
  const HomeCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GetBuilder<HomeCartController>(
        init: HomeCartController(),
        builder: (controller) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text(
                    "67".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.upload_rounded),
                      text: "Recharges",
                    ),
                    Tab(
                      icon: Icon(Icons.download_rounded),
                      text: "Withdraws",
                    ),
                    Tab(
                      icon: Icon(Icons.multiple_stop_outlined ),
                      text: "Transfers",
                    ),
                  ],
                ),
              ),
              body: controller.statusRequest == StatusRequest.loading
                  ? Center(
                      child: Lottie.asset("assets/lottie/loading1.json",
                          height: 80, width: 90),
                    )
                  : RefreshIndicator(
                      onRefresh: controller.getTransfers,
                      child: TabBarView(
                        children: [
                          ListView.builder(
                              itemCount: controller.recharges.length,
                              itemBuilder: (context, index) {
                                TransferModel transfer = controller
                                    .recharges.reversed
                                    .toList()[index];
                                return Container(
                                  width: w,
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 15, right: 5, left: 5),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                transfer.status.status.tr,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            const Gap(5),
                                              Text(DateFormat('yyyy-MM-dd HH:mm').format(transfer.createdAt)),
                                           
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // textDirection: TextDirection.ltr,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  transfer.sendedCurrency.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.02,
                                              ),
                                              FittedBox(
                                                  child: Text(
                                                      "${transfer.sendedBalance}"
                                                          .tr,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              249,
                                                              3,
                                                              3)))),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                              FittedBox(
                                                  child: Text(
                                                      transfer.sendedCurrency
                                                          .char.tr,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              247,
                                                              4,
                                                              4)))),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                              Icon(
                                                Icons.change_circle,
                                                color: transfer.status.color,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  transfer
                                                      .receivedCurrency.name.tr,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green),
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                              FittedBox(
                                                  child: Text(
                                                "${transfer.receivedBalance}"
                                                    .tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 2, 152, 7)),
                                              )),
                                              SizedBox(
                                                width: w * 0.01,
                                              ),
                                              FittedBox(
                                                  child: Text(
                                                transfer
                                                    .receivedCurrency.char.tr,
                                                style: const TextStyle(
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
                                      ])),
                                );
                              }),
                          ListView.builder(
                            itemCount: controller.withdraws.length,
                            itemBuilder: (context, index) {
                              TransferModel transfer =
                                  controller.withdraws.reversed.toList()[index];
                              return Container(
                                width: w,
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, right: 5, left: 5),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              transfer.status.status.tr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const Gap(5),
                                            Text(DateFormat('yyyy-MM-dd HH:mm').format(transfer.createdAt)),
                                            
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // textDirection: TextDirection.ltr,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                transfer.sendedCurrency.name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w * 0.02,
                                            ),
                                            FittedBox(
                                                child: Text(
                                                    "${transfer.sendedBalance}"
                                                        .tr,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 249, 3, 3)))),
                                            SizedBox(
                                              width: w * 0.01,
                                            ),
                                            FittedBox(
                                                child: Text(
                                                    transfer
                                                        .sendedCurrency.char.tr,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 247, 4, 4)))),
                                            SizedBox(
                                              width: w * 0.01,
                                            ),
                                            Icon(
                                              Icons.change_circle,
                                              color: transfer.status.color,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: w * 0.01,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                transfer
                                                    .receivedCurrency.name.tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w * 0.01,
                                            ),
                                            FittedBox(
                                                child: Text(
                                              "${transfer.receivedBalance}".tr,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 2, 152, 7)),
                                            )),
                                            SizedBox(
                                              width: w * 0.01,
                                            ),
                                            FittedBox(
                                                child: Text(
                                              transfer.receivedCurrency.char.tr,
                                              style: const TextStyle(
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
                                    ])),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: controller.transfers.length,
                            itemBuilder: (context, index) {
                              ExchangeModel transfer =
                                  controller.transfers.reversed.toList()[index];
                              return Container(
                                width: w,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(
                                      top: 15, right: 5, left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              '105'.tr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const Gap(5),
                                          Text(
                                            DateFormat('yyyy-MM-dd HH:mm')
                                              .format(transfer.sendedAt)
                                              ),
                                        ],
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: controller
                                                  .platformCurrency.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue),
                                            ),
                                            TextSpan(
                                              text:
                                                  "  ${transfer.sendedBalance} ${controller.platformCurrency.char.tr}"
                                                      .tr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 249, 3, 3),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Gap(w * 0.01),
                                      const Icon(
                                        Icons.change_circle,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: controller
                                                  .platformCurrency.name.tr,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                            TextSpan(
                                                text:
                                                    "  ${transfer.sendedBalance} ${controller.platformCurrency.char.tr}"
                                                        .tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 2, 152, 7)))
                                          ],
                                        ),
                                      ),
                                      const Divider(thickness: 5),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}

class HomeCartController extends GetxController {
  MainService mainService = Get.find();

  StatusRequest statusRequest = StatusRequest.loading;

  List<TransferModel> recharges = [];
  List<TransferModel> withdraws = [];
  List<ExchangeModel> transfers = [];

  CurrencyModel get platformCurrency => Get.find<AuthSerivce>()
      .currentUser
      .value!
      .platformSettings
      .platformCurrency;

  Future getTransfers() async {
    statusRequest = StatusRequest.loading;
    update();
    recharges = await TransferModel.loadAll(TransferTarget.recharges);
    withdraws = await TransferModel.loadAll(TransferTarget.withdraws);
    transfers = await ExchangeModel.loadAll();
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  void onInit() {
    getTransfers();
    super.onInit();
  }
}
