import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/view/Auth/ferigetpassword/forgetcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    Get.put(ForgetcrollerInp());
    return Scaffold(
        body: GetBuilder<ForgetcrollerInp>(
      builder: ((controller) => controller.statusRequest ==
              StatusRequest.loading
          ? Center(
              child: Lottie.asset("assets/lottie/loading1.json",
                  height: 80, width: 90),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView(children: [
                Form(
                  key: controller.formpassword,
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.1,
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: FittedBox(
                            child: Text(
                              "59".tr,
                              style: const TextStyle(
                                  fontFamily: "PTSerif",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: const [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.red,
                            size: 80,
                          ),
                          Icon(
                            Icons.verified_user,
                            size: 50,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "56".tr,
                            style: const TextStyle(
                                fontFamily: "PTSerif",
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 25,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          "55".tr,
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      myTextFormField(
                        enabled: true,
                        mycontroller: controller.email,
                        valid: (value) {
                          if (value!.isEmpty) {
                            return "2.5".tr;
                          }
                          if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value)) {
                            return "21".tr;
                          }
                          if (controller.errors.containsKey('email')) {
                            return controller.errors['email'];
                          }
                        },
                        iconData: Icons.email_outlined,
                        labeltext: "2".tr,
                        hintText: "2.5".tr,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      SizedBox(
                        height: h * 0.07,
                      ),
                      Container(
                        width: w * 0.4,
                        height: h * 0.08,
                        child: myMaterialButton(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          color: Colors.orangeAccent,
                          onPressed: () {
                            controller.forgetpassword();
                          },
                          text: "54".tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            )),
    ));
  }
}
