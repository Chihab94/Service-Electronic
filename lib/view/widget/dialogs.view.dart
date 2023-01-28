import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'button.view.dart';

class DialogsView extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin, padding;
  final double? width, height;
  final bool isDismissible;

  const DialogsView({
    Key? key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(16),
    this.width,
    this.height,
    this.isDismissible = true,
  }) : super(key: key);

  factory DialogsView.message(
    String title,
    String message, {
    List<DialogAction>? actions,
    bool isDismissible = true,
  }) =>
      DialogsView(
        isDismissible: isDismissible,
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo3.png",
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 20, 20, 20),
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 16,
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 38, 38, 38),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 3, right: 3),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (DialogAction action in (actions ?? DialogAction.ok))
                    ButtonView.text(
                      borderRaduis: 10,
                      onPressed: action.onPressed,
                      text: action.text,
                      backgroundColor: action.actionColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );

  factory DialogsView.loading({
    Key? key,
    String? title,
    String message = 'Loading...',
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? width,
    double? height,
  }) =>
      DialogsView(
        isDismissible: false,
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          textDirection: TextDirection.ltr,
          children: [
            if (title != null)
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 21, 21, 21),
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 16),
              child: Flex(
                direction: Axis.horizontal,
                textDirection: TextDirection.ltr,
                children: [
                  const CircularProgressIndicator(),
                  const Gap(10),
                  Text(
                    message,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 46, 46, 46),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  factory DialogsView.form({
    Key? key,
    required String title,
    GlobalKey<FormState>? formKey,
    required List<DialogFormField> fields,
    required Future Function(List<DialogFormField> fields) onSubmit,
    required Future Function() onCancel,
    bool isDismissible = true,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? width,
    double? height,
  }) {
    if (fields.isEmpty) throw ErrorHint('Fields list must be not empty');
    return DialogsView(
      child: Form(
        key: formKey,
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 29, 29, 29),
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 16,
              ),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  for (DialogFormField field in fields)
                    myTextFormField(
                      enabled: true,
                      textType: field.type, // واسنها تاع اتكست
                      mycontroller: field.controller,
                      labeltext: field.name,
                      valid: field.valid,
                      iconData: field.sefix,
                      hintText: field.name,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 3, right: 3),
              child: Flex(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                direction: Axis.horizontal,
                children: [
                  ButtonView.text(
                    text: 'Submit',
                    onPressed: () async {
                      await onSubmit(fields);
                    },
                  ),
                  ButtonView.text(
                    onPressed: () async {
                      await onCancel();
                      Get.back();
                    },
                    text: 'Cancel',
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future show() => Get.dialog(this, barrierDismissible: isDismissible);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => isDismissible,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0XFFDCDCDC),
        child: Container(
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFDCDCDC),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: child,
          ),
        ),
      ),
    );
  }
}

class DialogAction {
  final String text;
  final VoidCallback onPressed;
  final Color? actionColor;

  DialogAction({
    required this.text,
    required this.onPressed,
    this.actionColor,
  });

  static List<DialogAction> ok = [
    DialogAction(text: 'Ok', onPressed: () => Get.back()),
  ];
}

class DialogFormField {
  String name;
  TextInputType type;
  dynamic value;
  TextEditingController controller;
  IconData? prifix, sefix;
  bool isRequired;
  String? Function(String?)? valid;

  DialogFormField({
    required this.name,
    this.type = TextInputType.text,
    this.value,
    required this.controller,
    this.isRequired = true,
    this.valid,
    this.prifix,
    this.sefix,
  });
}
