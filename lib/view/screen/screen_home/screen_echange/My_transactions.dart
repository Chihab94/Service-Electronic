import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:service_electronic/Data/model/transfer.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller_Sella.dart';

class My_transactions extends StatelessWidget {
  const My_transactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "67".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: GetBuilder<TransfersController>(
          init: TransfersController(),
          builder: (controller) {
            return ListView.builder(
                itemCount: controller.transfers.length,
                itemBuilder: (context, index) {
                  TransferModel transfer =
                      controller.transfers.reversed.toList()[index];
                  return Container(
                    width: w,
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 15, right: 5, left: 5),
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
                              Gap(5),
                              Text(DateFormat('yyyy-MM-dd HH:mm').format(transfer.createdAt)),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                    child: Text("${transfer.sendedBalance}".tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 249, 3, 3)))),
                                SizedBox(
                                  width: w * 0.01,
                                ),
                                FittedBox(
                                    child: Text(
                                        "${transfer.sendedCurrency.char}".tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
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
                                    "${transfer.receivedCurrency.name}".tr,
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
                                      color: Color.fromARGB(255, 2, 152, 7)),
                                )),
                                SizedBox(
                                  width: w * 0.01,
                                ),
                                FittedBox(
                                    child: Text(
                                  "${transfer.receivedCurrency.char}".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 170, 6)),
                                )),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 5,
                          ),
                        ])),
                  );
                });
          }),
    );
  }
}
