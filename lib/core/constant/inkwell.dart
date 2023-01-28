import 'package:flutter/material.dart';

class myinkwell extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final TextAlign align;
  const myinkwell(
      {Key? key, required this.text, required this.onTap, required this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Text(
            text,
            textAlign: align,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
