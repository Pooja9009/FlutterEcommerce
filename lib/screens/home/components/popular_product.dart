import 'dart:io';

import 'package:flutter/material.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/data/remote_data_source/response/product_response.dart';
import 'package:techies_battle/model/product.dart';
import 'package:techies_battle/no_net/no_internet.dart';
import 'package:techies_battle/repository/remote_repository/product_repository.dart';
import 'package:techies_battle/screens/details/components/productDetail.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Our Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              getProduct(),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }

  FutureBuilder<ProductResponse?> getProduct() {
    return FutureBuilder(
        future: ProductRepository().getAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product>? categoryList = snapshot.data!.data!;
            print("The Category: -->${categoryList[0]}");
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                child: Row(
                  children: [
                    for (int index = 0; index < categoryList.length; index++)
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductDetailScreen(
                                            receivedProductId:
                                                categoryList[index].id,
                                            receivedProductPrice:
                                                categoryList[index].price,
                                            receivedFoodName:
                                                categoryList[index].title)));
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  categoryList[index]
                                                          .foodPhoto[0]
                                                          .isNotEmpty
                                                      ? categoryList[index]
                                                          .foodPhoto[0]
                                                      : imageUnavailable))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 140,
                              child: Text(
                                categoryList[index].title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    "Rs.${categoryList[index].price}",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                    ),
                                    // textAlign: TextAlign.left,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
          if (NetworkInterface.listSupported) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const NoInternet();
          }
        });
  }
}
