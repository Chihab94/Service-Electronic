import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/inkwell.dart';
import 'localiztioncontroller.dart';

class BottunLang extends GetView<LocaleController> {
  const BottunLang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15, left: 15),
          child: myinkwell(
              text: "English",
              onTap: () {
                controller.changelang("en");
              },
              align: TextAlign.end),
        ),
        myinkwell(
            text: "العربية",
            onTap: () {
              controller.changelang("ar");
            },
            align: TextAlign.end)
      ],
    );
  }
}
