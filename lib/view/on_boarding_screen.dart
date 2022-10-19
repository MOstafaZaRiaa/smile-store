import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../constance.dart';
import '../helper/local_storage_data.dart';
import 'auth/login_screen.dart';


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoarding = Get.put(LocalStorageData());
    final deviceWidth = Get.width;
    return SimpleBuilder(
      builder: (BuildContext context )=>
          IntroductionScreen(
            pages: [
              buildPageViewModel(
                deviceWidth,
                'Let\'s to shop our needs.',
                'Here you can find all different clothes.',
                'assets/images/on_boarding/img3.svg',
              ),
              buildPageViewModel(
                deviceWidth,
                'Very beautiful staff.',
                'Here you can find all different plants.',
                'assets/images/on_boarding/img2.svg',
              ),
              buildPageViewModel(
                deviceWidth,
                'Order now what you favorite.',
                'Here you can receive products immediately.',
                'assets/images/on_boarding/img1.svg',
              ),
            ],
            onDone: () {
              onBoarding.setTheAppUsedManyTimes();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            done: const Text(
              'Order Now',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            showSkipButton: true,
            nextFlex: 1,
            dotsFlex: 1,
            skip: const Text('Skip',style: TextStyle(color: primaryColor,fontSize: 16,),),
            next: const Icon(Icons.arrow_forward,color: primaryColor,),
            animationDuration: 1000,
            dotsDecorator: DotsDecorator(
                activeColor: primaryColor,
                size:const Size(10,10),
                activeSize:const Size(22,10),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                )
            ),
          ),
    );
  }

  PageViewModel buildPageViewModel(
      double deviceWidth,
      String title,
      String body,
      String image,
      ) {
    return PageViewModel(
      title: title,
      body: body,
      image: SvgPicture.asset(
        image,
        width: deviceWidth * 0.7,
      ),
      // image: Image.asset(
      //   image,
      //   width: deviceWidth * 0.7,
      // ),
      decoration: PageDecoration(
        titleTextStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: const TextStyle(
          fontSize: 20,
        ),
        imagePadding: const EdgeInsets.all(24).copyWith(
          bottom: 0,
        ),
      ),
    );
  }
}