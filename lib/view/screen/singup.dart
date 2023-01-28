import 'package:service_electronic/controller/controleer_signup.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/function/dealogAlartback.dart';

import 'package:service_electronic/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/constant/bottun.dart';
import '../../core/constant/castomTextFormField.dart';
import '../../core/constant/circleraviter.dart';
import '../../core/constant/inkwell.dart';

class singup extends StatelessWidget {
  const singup({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    Get.put(signupController());

    return Scaffold(
      body: WillPopScope(
        onWillPop: alirtExitApp,
        child: GetBuilder<signupController>(
          builder: ((controller) =>
              Container(
                color: Colors.white70,
                child: Form(
                  key: controller.formstate,
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: () {
                    controller.errors = {};
                    controller.update();
                  },
                  child: ListView(
                    children: [
                      Container(
                        height: h * 0.3,
                        decoration: const BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.04,
                            ),
                            const mycircleraviter(
                              maxRadius: 60,
                              minRadius: 30,
                              image: "assets/images/logo3.png",
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FittedBox(
                              child: Text(
                                "5".tr,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.03,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            myTextFormField(
                              enabled: true,
                              mycontroller: controller.firsetnem,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "20".tr;
                                }
                                if (value.length < 3) {
                                  return "50".tr;
                                }
                                if (controller.errors
                                    .containsKey('firstname')) {
                                  return controller.errors['firstname'];
                                }
                              },
                              hintText: "112".tr,
                              labeltext: "112".tr,
                              iconData: Icons.person_outlined,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            myTextFormField(
                              enabled: true,
                              mycontroller: controller.lastnem,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "20".tr;
                                }
                                if (value.length < 3) {
                                  return "50".tr;
                                }
                                if (controller.errors.containsKey('lastname')) {
                                  return controller.errors['lastname'];
                                }
                              },
                              hintText: "116".tr,
                              labeltext: "116".tr,
                              iconData: Icons.person_outlined,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            SizedBox(
                              height: h * 0.02,
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
                              //Mycontreller: ,
                              hintText: "2.5".tr,
                              labeltext: "2".tr,
                              iconData: Icons.email_outlined,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            myTextFormField(
                              enabled: true,
                              isNumber: true,
                              mycontroller: controller.phone,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "19".tr;
                                }
                                if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                    .hasMatch(value)) {
                                  return "23".tr;
                                }
                                if (controller.errors.containsKey('phone')) {
                                  return controller.errors['phone'];
                                }
                              },
                              hintText: "19".tr,
                              labeltext: "15".tr,
                              iconData: Icons.phone_android,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            GetBuilder<signupController>(builder: (controller) {
                              return myTextFormField(
                                enabled: true,
                                isPassword: true,
                                mycontroller: controller.password,
                                valid: (value) {
                                  if (value!.isEmpty) {
                                    return "3".tr;
                                  }
                                  if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                      .hasMatch(value)) {
                                    return "22".tr;
                                  }
                                  if (controller.errors
                                      .containsKey('password')) {
                                    return controller.errors['password'];
                                  }
                                },
                                hintText: "3".tr,
                                labeltext: "3.5".tr,
                                iconData: Icons.lock_outline,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              );
                            }),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            GetBuilder<signupController>(builder: (controller) {
                              return myTextFormField(
                                enabled: true,
                                isPassword: true,
                                mycontroller: controller.Confirmpassword,
                                valid: (value) {
                                  if (value!.isEmpty) {
                                    return "25".tr;
                                  }
                                  if (controller.password.text !=
                                      controller.Confirmpassword.text) {
                                    return "24".tr;
                                  }
                                },
                                hintText: "25".tr,
                                labeltext: "25".tr,
                                iconData: Icons.lock_outline,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 30),
                                  child: myinkwell(
                                    onTap: () {
                                      Get.offNamed(AppRoute.login);
                                    },
                                    text: "14".tr,
                                    align: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: h * 0.085,
                              width: w * 0.4,
                              child: myMaterialButton(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                color: Colors.amberAccent,
                                onPressed: () {
                                  controller.signup();
                                },
                                text: ("26".tr),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
