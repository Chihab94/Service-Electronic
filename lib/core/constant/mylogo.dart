import 'package:flutter/material.dart';

class mylogo extends StatelessWidget {
  final String text;
  const mylogo({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.40),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.amberAccent,
          image: DecorationImage(image: AssetImage('assets/images/logo.png')),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(45),
            bottomRight: Radius.circular(45),
          ),
        ),
      ),
      Container(
        width: w,
        height: h * 0.2,
        child: Center(
            child: FittedBox(
          child: Text(
            text,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
      ),
    ]);
  }
}
