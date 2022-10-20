import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'helper/binding.dart';
import 'helper/local_storage_data.dart';
import 'view/control_view.dart';
import 'view/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final onBoarding = Get.put(LocalStorageData());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme:  ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF00C569)),

      ),
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home: onBoarding.isUseForApp.value
          ? const OnBoardingPage()
          : const ControlView(),
    );
  }
}
