import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/data/remote_data_source/response/product_category_response.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/no_net/no_internet.dart';
import 'package:techies_battle/repository/remote_repository/product_category_repository.dart';
import 'package:techies_battle/screens/home/components/category_detail.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getMyCategory();
  }

  FutureBuilder<ProductCategoryResponse?> getMyCategory() {
    return FutureBuilder(
        future: ProductCatRepository().getAllProductCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductCategory>? categoryList = snapshot.data!.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int index = 0; index < categoryList.length; index++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryItems(
                                      productCategoryId: categoryList[index].id,
                                      productCategoryTitle:
                                          categoryList[index].foodCategoryTitle,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(categoryList[index]
                                              .foodCategoryImageUrl
                                              .isNotEmpty
                                          ? categoryList[index]
                                              .foodCategoryImageUrl
                                          : imageUnavailable))),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                              ),
                              child: Text(
                                categoryList[index].foodCategoryTitle,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          }  if (NetworkInterface.listSupported) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const NoInternet();
          }
        });
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: const Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            const SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
