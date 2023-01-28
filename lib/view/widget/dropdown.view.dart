import 'package:flutter/material.dart';

class DropDownView<T> extends StatelessWidget {
  final T? value;
  final String? label;
  final List<DropdownMenuItem<T>> items;
  final Function(T? value)? onChanged;
  final String? Function(T?)? validator;
  final EdgeInsets margin, padding;
  final double? width, heigth;
  final Color? textColor, backgroundColor, fieldTextColor;
  final Color borderColor, itemColor;
  final BorderRadius? borderRadius;
  final Icon? icon;

  const DropDownView({
    Key? key,
    this.value,
    this.margin = const EdgeInsets.symmetric(horizontal: 5),
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.width = double.infinity,
    this.heigth,
    required this.items,
    required this.onChanged,
    this.label,
    this.textColor,
    this.backgroundColor,
    this.borderColor = const Color(0xFF000000),
    this.itemColor = const Color(0xFF3A3A3A),
    this.fieldTextColor,
    this.validator,
    this.borderRadius,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: DropdownButtonFormField<T>(
          value: value,
          style: TextStyle(
            fontSize: 16,
            color: itemColor,
          ),
          validator: validator,
          items: items,
          onChanged: onChanged,
          dropdownColor: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          icon: icon,
        ),
      ),
    );
  }
}
