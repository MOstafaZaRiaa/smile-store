import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constance.dart';

class CustomStepper extends StatelessWidget {
   final int numberOfActiveStep ;
   const CustomStepper({ required this.numberOfActiveStep});

  Column check_out_step (
      {required int stepNumber, required String stepName, bool isStepActive = false}){
    return Column(
      children: [
        CircleAvatar(
          child: Text('$stepNumber',style: const TextStyle(color: Colors.white),),
          backgroundColor: isStepActive? primaryColor : greyAccent,
        ),
        Text(stepName),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          check_out_step(stepNumber: 1,stepName: 'Delivery',isStepActive: numberOfActiveStep>=0),
          Container(
            color: numberOfActiveStep>0 ? primaryColor : greyAccent,
            height: 2,
            width: 70,
          ),
          check_out_step(stepNumber: 2,stepName: 'Address',isStepActive: numberOfActiveStep>=1),
          Container(
            color: numberOfActiveStep>1 ? primaryColor : greyAccent,
            height: 2,
            width: 70,
          ),
          check_out_step(stepNumber: 3,stepName: 'Summer',isStepActive: numberOfActiveStep>=2),
        ],
      ),
    );
  }
  }