import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Conditions extends StatelessWidget {
  const Conditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: ListView(
            children: [
              Text(
                "301".tr,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "300".tr,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                "302".tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "303".tr,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
               Text(
                "309".tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),


               Text(
                "308".tr,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),






              Text(
                "12".tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "305".tr,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
               Text(
                "9".tr,
                style: const TextStyle(
                  fontSize: 18,fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "307".tr,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                "10".tr,
                style: const TextStyle(
                  fontSize: 18,fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "306".tr,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                "11".tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "304".tr,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              
             
              
            ],
          )),
    );
  }
}
