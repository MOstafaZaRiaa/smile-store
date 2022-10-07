// import 'package:ecommerce_app/constance.dart';
// import 'package:ecommerce_app/core/view_model/profile_view_model.dart';
// import 'package:ecommerce_app/view/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ChangePasswordScreen extends StatelessWidget {
//   late String newPassword;
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileViewModel>(
//       builder: (controller) => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios_outlined,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//           title: const CustomText(text: 'Change your password',alignment: Alignment.center,),
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           elevation: 0,
//           actions: [
//             IconButton(
//                 icon: const Icon(
//                   Icons.check,
//                   color: primaryColor,
//                 ),
//                 onPressed: () {
//                   controller.updatePassword(context,newPassword);
//
//                 },),
//           ],
//         ),
//         body: Form(
//           key: controller.keyForm,
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 15,
//                   vertical: 15,
//                 ),
//                 child: TextFormField(
//                   textInputAction: TextInputAction.next,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'New password',
//                   ),
//                   keyboardType: TextInputType.visiblePassword,
//                   onSaved: (value) {
//                     newPassword = value!;
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty || value.length < 8) {
//                       return 'Password can not been less than 8 characters';
//                     }
//                   },
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 15,
//                   vertical: 15,
//                 ),
//                 child: TextFormField(
//                   obscureText: true,
//                   controller: controller.textController,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm new password',
//                   ),
//                   keyboardType: TextInputType.visiblePassword,
//                   onSaved: (value) {},
//                   validator: (value) {
//                     if (value!.isEmpty || value.length < 8) {
//                       return 'Password can not been less than 8 characters';
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
