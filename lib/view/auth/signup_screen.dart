import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/view/auth/login_screen.dart';
import 'package:ecommerce_app/core/view_model/auth_view_model.dart';
import 'package:ecommerce_app/view/widgets/custom_button.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:ecommerce_app/view/widgets/custom_text_form_field.dart';

class SignUpScreen extends GetView<AuthViewModel> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Get.off(LoginScreen(),);
          },
        ),
      ),
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
                CustomText(
                  text: 'Sign Up,',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  text: 'Name',
                  hintText: 'mostafa',
                  onSave: (value){
                    controller.name=value;
                  },
                  onValidate: (value){
                    if(value==null){

                    }
                  },
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

                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'SIGN UP',
                  onPressed: (){
                    Get.focusScope!.unfocus();
                    if(_formkey.currentState!.validate()){
                      _formkey.currentState!.save();
                      controller.createUserWithEmailAndPassword(context);
                    }

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
