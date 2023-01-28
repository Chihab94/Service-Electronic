import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool>  alirtExitApp() {
  Get.defaultDialog(
    title: "64".tr, middleText: "65".tr,
    backgroundColor: Colors.amber,
    barrierDismissible:false ,
    
   actions: [
    ElevatedButton(
        onPressed: () {
          exit(0);
        },
        child:  Text("16".tr,style:const TextStyle(color: Colors.white) ,)),
    ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child:  Text("17".tr,style:const TextStyle(color: Colors.white))),
  ]);
  return Future.value(true);
}
