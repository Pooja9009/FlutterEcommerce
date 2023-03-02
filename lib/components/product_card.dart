import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/data/remote_data_source/response/product_response.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/repository/remote_repository/product_repository.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  final String? receivedFoodId;
  final String? receivedFoodPrice;
  final String? receivedFoodName;
  final String? receivedFoodImage;
  final double width, aspectRetio;

  const ProductCard(
      {Key? key,
      this.width = 140,
      this.aspectRetio = 1.02,
      required this.receivedFoodId,
      required this.receivedFoodPrice,
      required this.receivedFoodName,
      required this.receivedFoodImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
          width: getProportionateScreenWidth(width),
          child: GestureDetector(
              // onTap: () => Navigator.pushNamed(
              //   context,
              //   DetailsScreen.routeName,
              //   arguments: ProductDetailsArguments(product: product),
              // ),
              child: getAllProduct())),
    );
  }

  FutureBuilder<ProductResponse?> getAllProduct() {
    return FutureBuilder<ProductResponse?>(
        future: ProductRepository().getAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product>? productData = snapshot.data!.data!;
            print("The Foods: -->${productData[0].id}");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < productData.length; index++)
                  AspectRatio(
                    aspectRatio: 1.02,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Hero(
                        tag: productData,
                        child: Image.network(
                            productData[index].foodPhoto.isNotEmpty
                                ? productData[index].foodPhoto[0]
                                : imageUnavailable),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                const Text(
                  "momo",
                  style: TextStyle(color: Colors.black),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "200",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        height: getProportionateScreenWidth(28),
                        width: getProportionateScreenWidth(28),
                        decoration: const BoxDecoration(
                          // color: product.isFavourite
                          //     ? kPrimaryColor.withOpacity(0.15)
                          //     : kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Heart Icon_2.svg",
                          // color: product.isFavourite
                          //     ? const Color(0xFFFF4848)
                          //     : const Color(0xFFDBDEE4),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
