import 'package:flutter_svg/svg.dart';

import '../../../constance.dart';
import '../../../core/view_model/orders_history_view_model.dart';
import '../../../model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'display_order_screen.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  parseStringToTimeDate(timeDate) {
    final time_date = DateTime.tryParse(timeDate);
    String formattedDate = DateFormat.yMEd().format(time_date!);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = Get.width;
    final deviceHeight = Get.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
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
      body: GetBuilder<OrdersHistoryViewModel>(
        init: OrdersHistoryViewModel(),
        builder: (controller) => SafeArea(
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(color: primaryColor,),
                )
              : controller.allOrders.isEmpty?  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: deviceWidth ,
                child:const Center(
                  child:  Text(
                    'There is no orders yet.',
                    style: TextStyle(
                      fontSize: 22,
                      color: inProgressColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  'assets/images/no_orders.svg',
                  width: deviceWidth * .8,
                  height: deviceHeight * .6,
                ),
              )
            ],
          ) :
                  ListView.separated(
                    itemCount: controller.allOrders.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 18,
                    ),
                    itemBuilder: (context, index) {
                      return _customListTile(controller.allOrders[index]);
                    },
                  )
                ,
        ),
      ),
    );
  }

  Widget _customListTile(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Get.to(
            () => DisplayOrderScreen(
              orderModel: order,
            ),
          );
        },
        child: Card(
          child: ListTile(
            leading: Icon(
              Icons.edit_calendar_rounded,
              color: primaryColor,
            ),
            title: Text('Order ID : ${order.orderNo}'),
            subtitle: Text('${parseStringToTimeDate(order.timeDate)}'),
          ),
        ),
      ),
    );
  }
}
