import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/constant/inkwell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controller/controller_login.dart';
import '../../core/constant/bottun.dart';
import '../../core/constant/castomTextFormField.dart';
import '../../core/constant/mylogo.dart';
import '../../core/function/dealogAlartback.dart';
import '../../core/localization/bottun_language.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    Get.put(LoginController());
    return Scaffold(
      body: WillPopScope(
          onWillPop: alirtExitApp,
          child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: ((controller) =>
                Container(
                  color: Colors.white70,
                  child: Form(
                    key: controller.loginFormKey,
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: () {
                      controller.errors = {};
                      controller.update();
                    },
                    child: ListView(children: [
                      mylogo(text: "6".tr),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: GetBuilder<LoginController>(
                            init: LoginController(),
                            builder: (controller) {
                              return Column(children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "26.5".tr,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GetBuilder<LoginController>(
                                    init: LoginController(),
                                    builder: (controller) {
                                      return myTextFormField(
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
                                          if (controller.errors
                                              .containsKey('email')) {
                                            return controller.errors['email'];
                                          }
                                        },
                                        hintText: "2.5".tr,
                                        labeltext: "2".tr,
                                        iconData: Icons.email_outlined,
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      );
                                    }),
                                SizedBox(
                                  height: h * 0.025,
                                ),
                                GetBuilder<LoginController>(
                                    init: LoginController(),
                                    builder: (controller) {
                                      return myTextFormField(
                                        enabled: true,
                                        isPassword: true,
                                        mycontroller: controller.password,
                                        valid: (value) {
                                          if (value!.isEmpty) {
                                            return "3".tr;
                                          }
                                          if (controller.errors
                                              .containsKey('password')) {
                                            return controller
                                                .errors['password'];
                                          }
                                        },
                                        hintText: "3".tr,
                                        labeltext: "3.5".tr,
                                        iconData: Icons.lock_outline,
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      );
                                    }),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 7, bottom: 30),
                                      child: myinkwell(
                                        text: "4".tr,
                                        onTap: () {
                                          controller.forgietpassword();
                                        },
                                        align: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: h * 0.09,
                                  width: w * 0.46,
                                  child: myMaterialButton(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    color: Colors.amberAccent,
                                    onPressed: () {
                                      controller.login();
                                    },
                                    text: ("1".tr),
                                  ),
                                ),
                                myinkwell(
                                    text: "5".tr,
                                    onTap: () {
                                      controller.singup();
                                    },
                                    align: TextAlign.center),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: const BottunLang()),
                              ]);
                            },
                          )),
                    ]),
                  ),
                )),
          )),
    );
  }
}
