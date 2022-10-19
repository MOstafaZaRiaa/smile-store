import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth/login_screen.dart';
import '../core/view_model/auth_view_model.dart';
import '../core/view_model/control_view_model.dart';

class ControlView extends GetWidget<AuthViewModel> {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return SplashScreen();
        // }



        if (snapshot.hasData) {
          return GetBuilder<ControlViewModel>(
            init: ControlViewModel(),
            builder: (controller) => Scaffold(
              body: controller.currentScreen,
              bottomNavigationBar: _buildBottomNavigationBar(),
            ),
          );
        }
        return LoginScreen();
      },
    );
  }
  Widget _buildBottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder:(controller)=> BottomNavigationBar(
        currentIndex: controller.navigatorValue,
        items: [
          BottomNavigationBarItem(
            label: '',
            activeIcon: const Text('explore',style: TextStyle(fontWeight: FontWeight.bold,),),
            icon: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Image.asset(
                'assets/images/Icon_Explore.png',
                fit: BoxFit.contain,
                width: 20,
              ),
            ),

          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: const Text('cart',style: TextStyle(fontWeight: FontWeight.bold,),),
            icon: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Image.asset(
                'assets/images/Icon_Cart.png',
                fit: BoxFit.contain,
                width: 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: const Text('account',style: TextStyle(fontWeight: FontWeight.bold,),),
            icon: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Image.asset(
                'assets/images/Icon_User.png',
                fit: BoxFit.contain,
                width: 20,
              ),
            ),
          ),
        ],
        onTap: (index){
          controller.changeSelectedValue(index);
        },
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
      ),
    );
  }
}
