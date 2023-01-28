import 'package:flutter/material.dart';

class BottunScreen extends StatelessWidget {
  final Decoration? decoration;
  final double? height;
  final double? width;
  final String assetName;
  final String text;
  final Color? color;
  final void Function()? onPressed;
  const BottunScreen({
    Key? key,
    required this.text,
    this.color,
    this.onPressed,
    this.decoration,
    required this.assetName,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow:const [
          BoxShadow(
            color: Colors.black87,
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0,0),
          )
        ],
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(assetName),
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.only(top: 220),
        child: FittedBox(
            child: Text(
          text,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
