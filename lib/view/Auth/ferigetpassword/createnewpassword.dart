import 'package:lottie/lottie.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/view/Auth/ferigetpassword/newpasswordcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/statusRequest.dart';

class Createpassword extends StatelessWidget {
  const Createpassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    Get.put(NewpasswordControllerInp());
    return Scaffold(
        body: GetBuilder<NewpasswordControllerInp>(
      builder: ((Newpassword) => Newpassword.statusRequest ==
              StatusRequest.loading
          ? Center(
              child: Lottie.asset("assets/lottie/loading1.json",
                  height: 80, width: 90),
            )
          : Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(children: [
              Form(
                key: Newpassword.NewpasswordFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.1,
                    ),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: const [
                        Icon(
                          Icons.lock_outline,
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
                          "51".tr,
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
                        "53".tr,
                        style: const TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GetBuilder<NewpasswordControllerInp>(
                      init: NewpasswordControllerInp(),
                      builder: (Newpassword) {
                        return myTextFormField(
                          enabled: true,
                          isPassword: true,
                          mycontroller: Newpassword.Password,
                          valid: (value) {
                            if (value!.isEmpty) {
                              return "3".tr;
                            }
                            if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value)) {
                              return "22".tr;
                            }
                          },
                          iconData: Icons.lock_outline,
                          labeltext: "51".tr,
                          hintText: "3".tr,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        );
                      },
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    GetBuilder<NewpasswordControllerInp>(
                      builder: (Newpassword) {
                        return myTextFormField(
                          enabled: true,
                          isPassword: true,
                          mycontroller: Newpassword.ConfirmPassword,
                          valid: (value) {
                            if (value!.isEmpty) {
                              return "3".tr;
                            }
                            if (Newpassword.Password.text !=
                                Newpassword.ConfirmPassword.text) {
                              return "24".tr;
                            }
                          },
                          iconData: Icons.lock_outline,
                          labeltext: "25".tr,
                          hintText: "3".tr,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        );
                      },
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
                          Get.snackbar(
                            margin: const EdgeInsets.all(15),
                            icon: const Icon(
                              Icons.verified_outlined,
                              color: Colors.green,
                              size: 30,
                            ),
                            (""),
                            (""),
                            backgroundColor: Colors.white70,
                            titleText: Text(
                              "62".tr,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            messageText: Text(
                              "63".tr,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          );
                          Newpassword.newpassword();
                        },
                        text: "52".tr,
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
