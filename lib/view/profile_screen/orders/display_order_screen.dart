import '../../../model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constance.dart';
import '../../widgets/custom_text.dart';

class DisplayOrderScreen extends StatelessWidget {
  final OrderModel orderModel ;
  const DisplayOrderScreen({Key? key, required this.orderModel}) : super(key: key);
  parseStringToTimeDate(timeDate) {
    final time_date = DateTime.tryParse(timeDate);
    String formattedDate = DateFormat.yMEd().format(time_date!);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${orderModel.orderNo}',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

           SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width * .4,
                            child: Image(
                              image: NetworkImage(
                                orderModel.products![index].image!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: orderModel.products![index].name,
                            fontSize: 16.0,
                            // maxLine: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomText(
                            text:
                            '\$${orderModel.products![index].price.toString()}',
                            fontSize: 16.0,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) {
                        return  const SizedBox(
                          width: 15,
                        );
                      },
                      itemCount: orderModel.products!.length),
                ),
              ),
            const Divider(),
            Padding(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: Column(
                  children: [
                    const CustomText(
                      text: 'Shipping Address',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: orderModel.address!.street1! +
                          ', ' +
                          orderModel.address!.street2! +
                          ', ' ,
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                    CustomText(
                      text: orderModel.address!.city! +
                          ', ' +
                          orderModel.address!.state! +
                          ', ' +
                          orderModel.address!.country! ,
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ],
                ),
              ),
            const Divider(),
            Padding(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: Column(
                  children: [
                    const CustomText(
                      text: 'Order Time',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: parseStringToTimeDate(orderModel.timeDate),
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ],
                ),
              ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:  [
                  const CustomText(
                    text: 'Total Price :',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 10,),
                  CustomText(
                    text:
                    '\$${orderModel.totalPrice.toString()}',
                    fontSize: 16.0,
                    color: primaryColor,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
