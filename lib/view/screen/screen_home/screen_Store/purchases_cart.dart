import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:service_electronic/routes.dart';

import '../../../../Data/model/purchase.model.dart';
import '../../../../core/class/statusRequest.dart';

class Purchases extends StatelessWidget {
  const Purchases({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 59, 214, 131),
        title: Text('28.5'.tr,style:const TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: GetBuilder<PurchasesController>(
        init: PurchasesController(),
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.success) {
            return ListView.builder(
              itemCount: controller.purchases.length,
              itemBuilder: (context, index) {
                PurchaseModel purchase = controller.purchases[index];
                return InkWell(
                  onTap: () async {
                    await Get.toNamed(AppRoute.purchaseDetails, arguments: {
                      'purchase': purchase,
                      'target': 'seller',
                    });
                    controller.getPurchases();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(0.8, 0.5),
                            color: Color.fromARGB(45, 0, 0, 0),
                          )
                        ]),
                    child: Row(
                      children: [
                        Container(
                          width: w * 0.2,
                          height: w * 0.2,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(purchase.userImageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${"19.5".tr} : ${purchase.fullname}"),
                            Text("${"15".tr} : ${purchase.phone}"),
                            Text("${"31".tr} : ${purchase.product.name}"),
                            Text(
                                "${"33".tr} : ${purchase.totalPrice} DZD \n ${"142".tr} : ${purchase.count} unit"),
                          ],
                        ),
                        Spacer(),
                        Flexible(
                          child: Image.network(
                            purchase.product.imagesUrils[0],
                            height: h * 0.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class PurchasesController extends GetxController {
  RxList<PurchaseModel> purchases = <PurchaseModel>[].obs;

  StatusRequest statusRequest = StatusRequest.loading;

  @override
  void onInit() {
    getPurchases();
    super.onInit();
  }

  Future getPurchases() async {
    purchases.value = [];
    statusRequest = StatusRequest.loading;
    update();
    purchases.value = await PurchaseModel.sellerLoadAll();
    statusRequest = StatusRequest.success;
    update();
  }
}
