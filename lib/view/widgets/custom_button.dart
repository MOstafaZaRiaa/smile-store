import 'package:flutter/material.dart';

import 'package:ecommerce_app/constance.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final text;
  final Color color;
  final Color textColor;
  final Function? onPressed;

  const CustomButton({
    this.text,
    this.onPressed,
    this.textColor = Colors.white,
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(18),),
      ),
      onPressed: onPressed as void Function()?,
      child: CustomText(
        text: text,
        alignment: Alignment.center,
        color: textColor,
      ),
    );
  }
}
