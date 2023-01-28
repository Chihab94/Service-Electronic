import 'package:flutter/material.dart';


class ButtonView extends StatelessWidget {
  final Function()? onPressed;
  final EdgeInsets margin, padding;
  final Widget child;
  final Color? backgroundColor, borderColor;
  final double borderRaduis;
  final double? width, height;

  const ButtonView({
    Key? key,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderRaduis = 4,
    this.width,
    this.height,
  }) : super(key: key);

  ButtonView.text({
    Key? key,
    required Function()? onPressed,
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 15,
    ),
    required String text,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? borderColor,
    double borderRaduis = 4,
    double? width,
    double? height,
  }) : this(
          key: key,
          onPressed: onPressed,
          child: Text(
            text,
            style: textStyle ??
                const TextStyle(
                  //fontFamily: Consts.fontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
          margin: margin,
          padding: padding,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          borderRaduis: borderRaduis,
          width: width,
          height: height,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRaduis),
            side: BorderSide(
                color: borderColor ?? const Color(0xFF808080), width: 0.5),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class OutlineButtonView extends StatelessWidget {
  final Function()? onPressed;
  final EdgeInsets margin, padding;
  final Widget child;
  final Color? borderColor;
  final double borderRaduis;
  final double? width, height;

  const OutlineButtonView({
    Key? key,
    required this.onPressed,
    this.width,
    this.height,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
    required this.child,
    this.borderColor,
    this.borderRaduis = 10,
  }) : super(key: key);

  OutlineButtonView.text(
    String text, {
    Key? key,
    required Function()? onPressed,
    TextStyle textStyle = const TextStyle(
      //fontFamily: Consts.fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 17,
    ),
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = const EdgeInsets.symmetric(
      vertical: 13,
      horizontal: 15,
    ),
    Color? borderColor,
    double borderRaduis = 10,
    double? width,
    double? height,
  }) : this(
          key: key,
          onPressed: onPressed,
          child: Text(text, style: textStyle),
          margin: margin,
          padding: padding,
          borderColor: borderColor,
          borderRaduis: borderRaduis,
          width: width,
          height: height,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          //foregroundColor: UIThemeColors.primary,
          backgroundColor: Colors.transparent,
          elevation: 0,
          side: BorderSide(color: borderColor ?? Color(0XFFACACAC), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20
            ),
          ),
          padding: padding,
        ),
        child: child,
      ),
    );
  }
}

class CirclerButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final double size, borderSize;
  final Color? backgroundColor, borderColor;
  final EdgeInsets? margin;
  final EdgeInsets padding;

  const CirclerButton({
    required this.child,
    required this.onPressed,
    this.size = 50,
    this.backgroundColor,
    this.borderColor,
    this.borderSize = 1,
    this.margin,
    this.padding = const EdgeInsets.all(5),
    Key? key,
  }) : super(key: key);

  static CirclerButton icon({
    required IconData icon,
    required Function()? onPressed,
    Color? iconColor,
    double size = 50,
    double borderSize = 1,
    double? iconSize,
    Color? backgroundColor,
    Color borderColor = Colors.transparent,
    EdgeInsets? margin,
    EdgeInsets padding = const EdgeInsets.all(8),
  }) {
    return CirclerButton(
      onPressed: onPressed,
      size: size,
      borderSize:borderSize,
      backgroundColor: backgroundColor ?? Color.fromARGB(0, 3, 3, 243),
      borderColor: borderColor,
      margin: margin,
      padding: padding,
      child: Icon(
        icon,
        color: iconColor ?? Color.fromARGB(255, 249, 250, 249),
        size: iconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            CircleBorder(
              side: BorderSide(
                color: borderColor ?? Color.fromARGB(0, 22, 22, 236),
                width: borderSize,
              ),
            ),
          ),
          padding: MaterialStateProperty.all(padding),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              return states.contains(MaterialState.pressed)
                  ? Theme.of(context).splashColor
                  : null;
            },
          ),
        ),
        child: child,
      ),
    );
  }
}
