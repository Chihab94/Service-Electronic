import 'package:gap/gap.dart';
import 'package:service_electronic/Data/model/offer.model.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:service_electronic/routes.dart';
import 'package:service_electronic/view/widget/dropdown.view.dart';
import 'package:service_electronic/view/widget/network_image.view.dart';

import '../../../../controller/controller_service.dart';
import '../../../../core/class/statusRequest.dart';
import '../../../../core/constant/circleraviter.dart';
import '../../../../core/constant/icon_Bottun.dart';
import '../../../../core/localization/localiztioncontroller.dart';
import '../../../../core/services/notifiction.service.dart';

class MyService extends StatelessWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GetBuilder<ServiceController>(
      init: ServiceController(),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 249, 82, 82),
                title: Center(
                  child: Text(
                    "9".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                actions: [
                  MyIconBottun(
                    count: Get.find<NotificationService>().newServices.value,
                    radius: 8,
                    onTap: () {
                      Get.toNamed(AppRoute.offersCart);
                    },
                    icon: Icons.shopping_cart,
                    backgroundColor: Color.fromARGB(255, 249, 122, 113),
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
            body: controller.statusRequest == StatusRequest.loading
                ? Center(
                    child: Lottie.asset("assets/lottie/loading1.json",
                        height: 80, width: 90),
                  )
                : ListView.builder(
                    itemCount: controller.offers.length,
                    itemBuilder: (context, index) {
                      OfferModel offer = controller.offers[index];
                      String lang = Get.find<LocaleController>().language.languageCode;
                      return InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.offerRequest, arguments: offer);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Color.fromARGB(255, 232, 232, 232),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  offer.title[lang]!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(10),
                                SizedBox(
                                  height: h * 0.25,
                                  child: NetworkImageView(
                                    url: offer.image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  offer.description[lang]!,
                                  textAlign: TextAlign.center,
                                ),
                                for (Map subOffer in offer.subOffers.values)
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${subOffer['title_$lang']!}: ",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "${subOffer['price']} DZD",
                                          style: const TextStyle(
                                            color: Color(0xFF1287E7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ));
      },
    );
  }
}
