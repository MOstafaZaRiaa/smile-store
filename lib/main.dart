import 'package:ecommerce_app/view/profile_screen/orders/orders_history_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'helper/binding.dart';
import 'package:firebase_core/firebase_core.dart';


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
    ToastContext().init(context);
    return GetMaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home: const OrdersHistoryScreen(),
    );
  }
}
