import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constant/circleraviter.dart';

class Supportlink extends StatelessWidget {
  const Supportlink({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
      title: Center(
        child: Text("159".tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),),
      ),
      ),
      body: Stack(children: [
        Container(
          color: Colors.black,
          height: h,
          width: w,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Flexible(
                   child: Text(
                     "160".tr,
                     style: const TextStyle(
                     fontWeight: FontWeight.bold, fontSize: 18),
                   ),
                 ),
                SizedBox(
                  height: h * 0.10,
                ),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse(''));
                  },
                  child: InkWell(
                    onTap: () {
                      launchUrl(
                          Uri.parse('https://www.facebook.com/ChihabR94'));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 52,
                          child: Container(
                            height: h * 0.12,
                            width: h * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/facebook.png"))),
                          ),
                        ),
                        const Gap(10),
                        Flexible(
                          child: FittedBox(
                              child: Text(
                            "157".tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,color: Colors.blue),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('https://t.me/+pwKpK4YhXHEyYjRk'));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 52,
                        child: Container(
                          height: h * 0.12,
                          width: h * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/telgram.png"))),
                        ),
                      ),
                      const Gap(10),
                      Flexible(
                        child: FittedBox(
                            child: Text(
                          "158".tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18,color: Colors.blue),
                        )),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('mailto:service.m.e94@gmail.com'));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 52,
                        child: Container(
                          height: h * 0.12,
                          width: h * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/gemail.png"))),
                        ),
                      ),
                      const Gap(10),
                      Flexible(
                        child: FittedBox(
                            child: Text(
                          "156".tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18,color: Colors.blue),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
