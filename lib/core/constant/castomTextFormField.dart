import 'package:flutter/material.dart';

class myTextFormField extends StatefulWidget {
  final String labeltext;
  final String? suffixText;
  final Color? iconcolor;
  final Color? focusColor;
  final String? hintText;
  final int? maxLines;
  TextInputType textType;
  bool? obscureText;
  final IconData? iconData;
  final String? Function(String?)? valid;
  final TextEditingController? mycontroller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;
  final bool enabled;
  final InputBorder? disabledBorder;
  final void Function()? onTapicon;
  final InputBorder? border;
  final EdgeInsets margin;
  myTextFormField({
    Key? key,
    this.obscureText,
    this.onTapicon,
    required this.labeltext,
    this.iconData,
    this.hintText,
    this.valid,
    required this.mycontroller,
    this.onChanged,
    this.textType = TextInputType.text,
    this.onSubmit,
    this.enabled = true,
    this.disabledBorder,
    this.border,
    this.maxLines = 1,
    this.suffixText,
    this.iconcolor,
    this.focusColor,
    bool isPassword = false,
    bool isNumber = false,
    this.margin = EdgeInsets.zero,
  }) : super(key: key) {
    if (isPassword) {
      textType = TextInputType.visiblePassword;
      obscureText = true;
    }
    if (isNumber) {
      textType = const TextInputType.numberWithOptions(decimal: true);
    }
  }

  @override
  State<myTextFormField> createState() => _myTextFormFieldState();
}

class _myTextFormFieldState extends State<myTextFormField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText =
        widget.obscureText ?? widget.textType == TextInputType.visiblePassword;
  }

  changeTextStatus() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: widget.textType,
        controller: widget.mycontroller,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: widget.onSubmit,
        validator: widget.valid,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
            focusColor: widget.focusColor,
            suffixText: widget.suffixText,
            disabledBorder: widget.disabledBorder,
            enabled: widget.enabled,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.only(left: 3, right: 10),
                child: Text(
                  widget.labeltext,
                  style: const TextStyle(fontSize: 20),
                )),
            suffixIcon: InkWell(
              onTap: () {
                if (widget.onTapicon != null) widget.onTapicon!();
                if (widget.textType == TextInputType.visiblePassword) {
                  changeTextStatus();
                }
              },
              child: Icon(
                widget.iconData ??
                    (widget.textType == TextInputType.visiblePassword
                        ? (obscureText
                            ? Icons.visibility_off
                            : Icons.visibility)
                        : null),
                color: widget.iconcolor,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 12),
            border: widget.border),
      ),
    ); //TextFormField();
  }
}
