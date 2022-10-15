import 'package:ecommerce_app/view/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../control_view.dart';

class OrderIsPlaced extends StatelessWidget {
  const OrderIsPlaced({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final screenHeight =  MediaQuery.of(context).size.height;
    final screenWidth =  MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/order_is_placed.gif',width:screenWidth*.5 ,height:screenHeight*.5 ,),
            SizedBox(
              height: screenHeight * .09,
              child: const Text(
                'Your Order Has Been Placed \n'
                    '             Successfully!',

                style: TextStyle(fontSize: 24,),
                softWrap: true,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomButton(
                text: 'Finish',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ControlView(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
