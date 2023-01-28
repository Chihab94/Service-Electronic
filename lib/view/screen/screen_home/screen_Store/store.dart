//import 'dart:io';
import 'package:gap/gap.dart';
import 'package:service_electronic/Data/model/category.model.dart';
import 'package:service_electronic/Data/model/product.model.dart';
import 'package:service_electronic/controller/controller_Store.dart';

import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/core/constant/circleraviter.dart';
import 'package:service_electronic/core/constant/icon_Bottun.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/routes.dart';
import 'package:service_electronic/view/widget/network_image.view.dart';
import 'package:service_electronic/view/widget/vewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/class/statusRequest.dart';
import '../../../../core/localization/localiztioncontroller.dart';
import '../../../../core/services/notifiction.service.dart';

//import '../../../../Data/model/store_json.dart';

class MyStore extends StatelessWidget {
  final String? montage;
  final String? wassf;
  final String? prx;
  final String? nem;
  final ProductModel? modelStore;

  const MyStore({
    Key? key,
    this.montage,
    this.wassf,
    this.prx,
    this.nem,
    this.modelStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainService myService = Get.find();
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GetBuilder<StoreController>(
        init: Get.put(StoreController()),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 59, 214, 131),
                  title: Center(
                    child: Text(
                      "11".tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  actions: [
                    if (controller.user.value!.sellerStatus?.isAccpeted == true)
                      MyIconBottun(
                        count:
                            Get.find<NotificationService>().newPurchaseRequests.value,
                        onTap: () => Get.toNamed(AppRoute.purchases),
                        icon: Icons.history,
                        backgroundColor: Colors.red,
                      ),
                    const Gap(2),
                    MyIconBottun(
                      count: Get.find<NotificationService>().newPurchases.value,
                      onTap: () => Get.toNamed(AppRoute.notification),
                      icon: Icons.shopping_cart,
                      backgroundColor: Colors.red,
                    ),
                    mycircleraviter(
                      image: "assets/images/logo3.png",
                      minRadius: 5,
                      maxRadius: 23,
                      height: h * 0.50,
                      width: w * 0.50,
                      backgroundColor: Colors.white,
                    ),
                  ]),
              floatingActionButton: controller
                              .user.value!.identityVerifyStatus.isVerfited ==
                          false ||
                      controller.user.value!.sellerStatus?.isChecking == true
                  ? null
                  : Align(
                      alignment: Get.find<LocaleController>().language.languageCode == 'ar'
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: FloatingActionButton(
                        backgroundColor:
                            controller.user.value!.sellerStatus?.isAccpeted ==
                                    true
                                ? const Color.fromARGB(255, 59, 214, 131)
                                : const Color.fromARGB(255, 247, 119, 110),
                        onPressed: () async {
                          await Get.toNamed(

                            controller.user.value!.sellerStatus?.isAccpeted ==
                                    true
                                ? AppRoute.addProduct
                                : AppRoute.seller,
                          );
                          if (controller.user.value!.sellerStatus?.isAccpeted ==
                              true) {
                            controller.refreshProducts();
                          }
                        },
                        child: Icon(
                          controller.user.value!.sellerStatus?.isAccpeted ==
                                  true
                              ? Icons.add_shopping_cart_rounded
                              : Icons.add_task_outlined,
                          size: 32,
                        ),
                      ),
                    ),
              body: GetBuilder<StoreController>(
                  init: Get.find(),
                  builder: (controller) {
                    return controller.pageStatusRequest == StatusRequest.loading
                        ? Center(
                            child: Lottie.asset("assets/lottie/loading1.json",
                                height: 80, width: 90),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: RefreshIndicator(
                              onRefresh: controller.refreshProducts,
                              child: ListView(children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 20, top: 20, bottom: 15),
                                  child: myTextFormField(
                                    enabled: true,
                                    mycontroller: controller.serch,
                                    valid: (v) {},
                                    onChanged: controller.onSearch,
                                    labeltext: "110".tr,
                                    iconData: Icons.search,
                                    hintText: "111".tr,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                                // =============== كل الموديل =================================
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    for (CategoryModel category
                                        in controller.categories)
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: InkWell(
                                              onTap: () => controller
                                                  .changeCategory(category.id),
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 59, 214, 131),
                                                  radius: 50,
                                                  child: NetworkImageView(
                                                    url: category.imageUrl,
                                                    height: h * 0.116,
                                                    width: w * 0.245,
                                                    backgroundColor: controller
                                                                .currenctCategory ==
                                                            category.id
                                                        ? Color.fromARGB(
                                                            255, 59, 214, 131)
                                                        : Colors.white,
                                                    borderRadius: 50,
                                                    fit: BoxFit.fill,
                                                    setItInDecoration: true,
                                                  )),
                                            ),
                                          ),
                                          Text(category.name),
                                        ],
                                      ),
                                  ]),
                                ),
                                Divider(
                                  height: h * 0.03,
                                  thickness: 5,
                                ),
                                //=========== من هون يبدا عرض المنتجات ===========================
                                GetBuilder<StoreController>(
                                    init: StoreController(),
                                    builder: (controller) {
                                      List<ProductModel> items =
                                          controller.products.reversed.toList();
                                      return Container(
                                          child: controller
                                                      .productsStatusRequest ==
                                                  StatusRequest.loading
                                              ? const CircularProgressIndicator()
                                              : items.isEmpty
                                                  ? const Text("no item")
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const ScrollPhysics(),
                                                      itemCount: items.length,
                                                      itemBuilder:
                                                          (context, indx) {
                                                        return VewModel(
                                                          buy: () {
                                                            controller.buy(
                                                                items[indx]);
                                                          },
                                                          product: items[indx],
                                                          // onTap: () {
                                                          //   controller
                                                          //       .AccontSelle();
                                                          // },
                                                          onTapcontry: controller
                                                                  .recting
                                                              ? null
                                                              : () => controller
                                                                  .react(items[
                                                                      indx]),
                                                          onRate:
                                                              controller.rate,
                                                        );
                                                      },
                                                    ));
                                    }),
                              ]),
                            ),
                          );
                  }));
        });
  }
}
