import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:service_electronic/Data/model/offer.model.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Service/offer_request_controller.dart';
import 'package:service_electronic/view/widget/dropdown.view.dart';

import '../../../../core/class/statusRequest.dart';
import '../../../../core/constant/bottun.dart';
import '../../../../core/localization/localiztioncontroller.dart';

class OfferRequest extends StatelessWidget {
  const OfferRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 252, 89, 77),
          title: const Text(
            'Request Offer',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: GetBuilder<OfferRequestController>(
        init: OfferRequestController(),
        builder: (controller) {
          String lang = Get.find<LocaleController>().language.languageCode;
          OfferModel offer = controller.offer;
          return SingleChildScrollView(
            child: Form(
              key: controller.requestKey,
              onChanged: () {
                controller.errors = {};
                controller.update();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      'Requset offer (#${offer.id})',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    DropDownView<String>(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        value: controller.selectedSubOffer,
                        items: [
                          const DropdownMenuItem(
                              value: '-1', child: Text('SubOffer')),
                          for (String name in offer.subOffers.keys)
                            DropdownMenuItem(
                              value: name,
                              child:
                                  Text(offer.subOffers[name]!['title_$lang']),
                            ),
                        ],
                        validator: (value) {
                          if (value == '-1') return '';
                          if (controller.errors.containsKey('sub_offer')) {
                            return controller.errors['sub_offer'];
                          }
                        },
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedSubOffer = value;
                            controller.update();
                          }
                        }),
                    for (Map field in offer.fields.values)
                      Container(
                        child: myTextFormField(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          labeltext: field['title_$lang'],
                          hintText: field['title_$lang'],
                          mycontroller: controller.getFieldController(
                            field['name'],
                          ),
                          valid: (text) {
                            if (text!.isEmpty &&
                                (field['validate'] as String)
                                    .contains('required')) {
                              return 'this field is required';
                            }
                            if ((field['validate'] as String).contains('email') &&
                                !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(text)) {
                              return "21".tr;
                            }
                            if (controller.errors.containsKey(field['name'])) {
                              return controller.errors[field['name']];
                            }
                          },
                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20),))
                        ),

                      ),
                    const Gap(10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${"Total Price".tr}: ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                "${offer.subOffers[controller.selectedSubOffer]?['price'] ?? 0} DZD",
                            style: TextStyle(
                              color: controller.user.value!.balance >=
                                      (double.tryParse((offer.subOffers[
                                                      controller
                                                          .selectedSubOffer]
                                                  ?['price'])
                                              .toString()) ??
                                          0)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!controller.validateBalance.value)
                      const Text('You Don\'t have required balance'),
                    const Gap(10),
                    myMaterialButton(
                      color: const Color.fromARGB(255, 251, 75, 75),
                      onPressed: controller.submit,
                      text: "127".tr,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    )
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
