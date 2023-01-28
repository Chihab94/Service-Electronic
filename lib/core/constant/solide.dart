import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_electronic/view/widget/network_image.view.dart';

import '../services/auth.service.dart';

class MySolide extends StatelessWidget {
  final CurrencyModel currency;
  final Function()? onPressed;
  final bool isSelected, showMax;

  const MySolide({
    Key? key,
    required this.currency,
    this.onPressed,
    this.isSelected = false,
    this.showMax = true,
  }) : super(key: key);

  UserModel get user => Get.find<AuthSerivce>().currentUser.value!;

  CurrencyModel get platformCurrency => user.platformSettings.platformCurrency;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5).copyWith(top: 5),
      // width: w * 8.2,
      height: h * 0.08,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueGrey : Colors.white,
            border: Border.all(color: Colors.black54, width: 1),
          ),
          child: Row(
            children: [
              SizedBox(
                width: w * 0.008,
              ),
              SizedBox(
                width: w * 0.13,
                height: w * 0.13,
                child: NetworkImageView(
                  url: currency.image,
                  headers: Applink.imageHeaders,
                  fit: BoxFit.fill,
                  borderRadius: 5,
                ),
              ),
              SizedBox(
                width: w * 0.02,
              ),
              Flexible(
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        currency.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    if (showMax)
                      Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: currency.id == platformCurrency.id
                                ? user.balance.toStringAsFixed(2)
                                : currency.maxReceive.toStringAsFixed(2),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(text: " "),
                          TextSpan(
                            text: currency.char,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      )),
                    // Flex(
                    //   direction: Axis.horizontal,
                    //   children: [
                    //     if (showMax)
                    //       Text(
                    //         currency.id == platformCurrency.id
                    //             ? user.balance.toStringAsFixed(2)
                    //             : currency.maxReceive.toStringAsFixed(2),
                    //         style: const TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     SizedBox(
                    //       width: w * 0.008,
                    //     ),
                    //     Text(
                    //       currency.char,
                    //       style: const TextStyle(
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.green),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
