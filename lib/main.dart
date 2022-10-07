import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'helper/binding.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ecommerce_app/view/control_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce App',
      initialBinding: Binding(),
      home: ControlView(),
    );
  }
}
