import 'package:flutter/material.dart';

class mycircleraviter extends StatelessWidget {
  final String image;
  final double maxRadius;
  final double minRadius;
  final double height;
  final double width;
  final Color? backgroundColor;
  final String assets = "assets/images/";
  final String image1 = "logo3.png";

  const mycircleraviter({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
    required this.maxRadius,
    required this.minRadius,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      maxRadius: maxRadius,
      minRadius: minRadius,
      child: Image.asset(
        image,
        height: height,
        width: width,
      ),
    );
  }
}
