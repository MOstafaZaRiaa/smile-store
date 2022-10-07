import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/constance.dart';
import 'package:ecommerce_app/view/widgets/custom_button.dart';
import 'package:ecommerce_app/view/widgets/custom_button_social.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:ecommerce_app/view/widgets/custom_text_form_field.dart';
import 'package:ecommerce_app/core/view_model/auth_view_model.dart';
import 'package:ecommerce_app/view/auth/signup_screen.dart';

class LoginScreen extends GetView<AuthViewModel> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: 10,
            right: 10,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Welcome,',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(SignUpScreen());
                      },
                      child: CustomText(
                        text: 'Sign Up,',
                        fontSize: 18.0,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                CustomText(
                  text: 'Sign in to Continue',
                  fontSize: 14.0,
                  color: Color(0xFF929292),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  text: 'Email',
                  hintText: 'iamdavid@gmail.com',
                  onSave: (value){
                    controller.email=value;
                  },
                  onValidate: (value){
                    if(value==null){
                      print('zobbry');
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextFormField(
                  hintText: '********',
                  text: 'Password',
                  obscureText: true,
                  onSave: (value){
                    controller.password=value;
                  },
                  onValidate: (value){
                    if(value==null){
                      print('zoppry');
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'Forgot Password?',
                  alignment: Alignment.centerRight,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  text: 'SIGN IN',
                  onPressed: (){
                    Get.focusScope!.unfocus();
                    if(_formkey.currentState!.validate()){
                      _formkey.currentState!.save();
                    }
                    controller.signInWithEmailAndPassword(context);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                CustomText(
                  text: '-OR-',
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButtonSocial(
                  imagePath: 'assets/images/Facebook.png',
                  text: 'Sign In with Facebook',
                  onPressed: (){
                    controller.facebookSignInMethod(context);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButtonSocial(
                  imagePath: 'assets/images/Google.png',
                  text: 'Sign In with Google',
                  onPressed: (){
                    controller.googleSignInMethod(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
