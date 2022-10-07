import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final text;
  final color;
  final alignment;
  final fontWeight;
  final fontSize;
  final height;
  final maxLine;

  const CustomText({
    this.text = '',
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.fontWeight,
    this.maxLine,
    this.fontSize,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLine,
        style: TextStyle(
          color: color,
          height: height,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
