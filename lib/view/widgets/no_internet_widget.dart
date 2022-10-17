import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constance.dart';

Widget buildNoInternetWidget(context) {
  return Center(
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width ,
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
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.width * .6,
            ),
          )
        ],
      ),
    ),
  );
}
