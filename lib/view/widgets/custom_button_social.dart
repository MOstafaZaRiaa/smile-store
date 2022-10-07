import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButtonSocial extends StatelessWidget {
  final imagePath;
  final text;
  final Function? onPressed;

  const CustomButtonSocial({this.imagePath,this.onPressed, this.text,});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1,color: Colors.grey.shade300,),
        color: Colors.grey.shade50,
      ),
      child: TextButton(
        onPressed:onPressed as void Function()?,
        child: Row(
          children: [
            Image.asset(imagePath),
            SizedBox(width: 90,),
            CustomText(text: text,),
          ],
        ),
      ),
    );
  }
}
