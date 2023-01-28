import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyIconBottun extends StatelessWidget {
  final void Function()? onTap;
  final int count;
  final IconData? icon;
  final Color? backgroundColor;

  final double? radius;
  const MyIconBottun({
    Key? key,
    required this.count,
    this.icon,
    this.radius,
    this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: w * 0.1,
        child: Stack(
          children: [
            Positioned(
              top: h * 0.013,
              left: w * 0.01,
              child: Icon(
                icon,
                size: w * 0.083,
              ),
            ),
            if(count!= 0)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: w * 0.05,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text('$count'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
