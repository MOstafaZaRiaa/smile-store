import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constance.dart';
import '../core/view_model/search_screen_view_model.dart';
import 'widgets/custom_text.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  Widget searchBar(controller){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        cursorColor: greyAccent,
        controller: controller.searchTextController,
        style:
        const TextStyle(color: greyAccent, fontSize: 18),
        onChanged: (searchedCharacter) {
          controller.addSearchedFOrItemsToSearchedList(
              searchedCharacter);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenViewModel>(
      init: SearchScreenViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_outlined,color: Colors.black,)),
          title: searchBar(controller),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: const [
            Icon(Icons.search_rounded,color: Colors.black,),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.searchedProducts.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 0.9),
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => ProductDetailScreen(
                              model: controller.searchedProducts[index],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 220,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    controller
                                        .searchedProducts[index].image!,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: controller
                                    .searchedProducts[index].name,
                                fontSize: 16.0,
                                // maxLine: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              //description of product
                              CustomText(
                                text: controller
                                    .searchedProducts[index].description,
                                fontSize: 12.0,
                                maxLine: 1,
                                color: greyAccent,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                text:
                                    '\$${controller.searchedProducts[index].price.toString()}',
                                fontSize: 16.0,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
