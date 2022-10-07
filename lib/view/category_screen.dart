import 'package:ecommerce_app/helper/color_extension.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constance.dart';
import 'package:ecommerce_app/view/product_detail_screen.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

class CategoryScreen extends StatelessWidget {
  final String? title;

  const CategoryScreen({
    this.title,
  });

  Widget build(BuildContext context) {
    final deviceWidth = Get.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomText(
          text: title,
          color: Colors.black,
          alignment: Alignment.center,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,

      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Products')
                      .where('category', isEqualTo: title)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final products = snapshot.data.docs;
                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 0.9),
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => ProductDetailScreen(
                                model: ProductModel(
                                  name: products[index]['name'],
                                  image: products[index]['image'],
                                  description: products[index]['description'],
                                  price: products[index]['price'],
                                  size: products[index]['size'],
                                  color:HexColor.fromHex(products[index]['color']) ,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 220,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      products[index]['image'],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: products[index]['name'],
                                  fontSize: 16.0,
                                  // maxLine: 1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //description of product
                                CustomText(
                                  text: products[index]['description'],
                                  fontSize: 12.0,
                                  maxLine: 1,
                                  color: greyAccent,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomText(
                                  text:
                                      '\$${products[index]['price'].toString()}',
                                  fontSize: 16.0,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
