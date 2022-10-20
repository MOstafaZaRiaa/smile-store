import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constance.dart';

Widget buildNoInternetWidget(context) {
  final deviceWidth = Get.width;
  final deviceHeight = Get.height;
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: deviceWidth ,
          child:const Center(
            child:  Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: inProgressColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SvgPicture.asset(
            'assets/images/no_internet.svg',
            width: deviceWidth * .8,
            height: deviceHeight * .6,
          ),
        )
      ],
    ),
  );
}
