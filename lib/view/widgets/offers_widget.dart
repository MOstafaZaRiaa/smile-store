import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

Widget offersWidget(List offers) {
  return CarouselSlider.builder(
    itemCount: 3,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        Image.network(offers[itemIndex]),
    options: CarouselOptions(
      autoPlay: true,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      initialPage: 2,
    ),
  );
}
