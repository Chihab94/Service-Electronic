import 'package:flutter/material.dart';

class myMaterialButton extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? style;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onPressed;

  const myMaterialButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
    this.style,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 15),
        child: MaterialButton(
          onPressed: onPressed,

          child: Text(
            text,
            style: style,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.5),
          color: color,
          borderRadius: borderRadius,
          boxShadow:const [BoxShadow(
                      color: Colors.black87,
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    )]
        ));
  }
}
