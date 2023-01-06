import 'dart:io';

import 'package:flutter/material.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/no_net/no_internet.dart';
import 'package:techies_battle/screens/details/components/productDetail.dart';


import '../../../data/remote_data_source/response/product_response.dart';
import '../../../repository/remote_repository/product_repository.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Special for you",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        getProductCategory(),
      ],
    );
  }

  // =========== API
  FutureBuilder<ProductResponse?> getProductCategory() {
    return FutureBuilder(
        future: ProductRepository().getAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product>? specialProduct = snapshot.data!.data!;
            print("The Category: -->${specialProduct[0]}");
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int index = 2; index < specialProduct.length; index++)
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(20)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(
                                        receivedProductId:
                                            specialProduct[index].id,
                                        receivedProductPrice:
                                            specialProduct[index].price,
                                        receivedFoodName:
                                            specialProduct[index].title,
                                      )));
                        },
                        child: SizedBox(
                          width: getProportionateScreenWidth(242),
                          height: getProportionateScreenWidth(100),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Image.network(
                                  specialProduct[index].foodPhoto[0].isNotEmpty
                                      ? specialProduct[index].foodPhoto[0]
                                      : imageUnavailable,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0xFF343434)
                                            .withOpacity(0.4),
                                        const Color(0xFF343434)
                                            .withOpacity(0.15),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(15.0),
                                    vertical: getProportionateScreenWidth(10),
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${specialProduct[index].title}\n",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(18),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // TextSpan(text: "${} Brands")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            );
          } else if (NetworkInterface.listSupported) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const NoInternet();
          }
        });
  }
}

// // =========== API
// FutureBuilder<ProductResponse?> getProductCategory() {
//   return FutureBuilder(
//       future: ProductRepository().getAllProductCategory(widget.categoryId),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<Product>? categoryList = snapshot.data!.data!;
//           print("The Category: -->${categoryList[0]}");
//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: getProportionateScreenWidth(20)),
//                   child: GestureDetector(
//                     onTap: (){},
//                     child: SizedBox(
//                       width: getProportionateScreenWidth(242),
//                       height: getProportionateScreenWidth(100),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Stack(
//                           children: [
//                             Image.asset(
//                               image,
//                               fit: BoxFit.cover,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     const Color(0xFF343434).withOpacity(0.4),
//                                     const Color(0xFF343434).withOpacity(0.15),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: getProportionateScreenWidth(15.0),
//                                 vertical: getProportionateScreenWidth(10),
//                               ),
//                               child: Text.rich(
//                                 TextSpan(
//                                   style: const TextStyle(color: Colors.white),
//                                   children: [
//                                     TextSpan(
//                                       text: "$category\n",
//                                       style: TextStyle(
//                                         fontSize:
//                                             getProportionateScreenWidth(18),
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     TextSpan(text: "$numOfBrands Brands")
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: getProportionateScreenWidth(20)),
//               ],
//             ),
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       });
// }

// //======================
// class SpecialOfferCard extends StatelessWidget {
//   const SpecialOfferCard({
//     Key? key,
//     required this.category,
//     required this.image,
//     required this.numOfBrands,
//     required this.press,
//   }) : super(key: key);

//   final String category, image;
//   final int numOfBrands;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
//       child: GestureDetector(
//         onTap: press,
//         child: SizedBox(
//           width: getProportionateScreenWidth(242),
//           height: getProportionateScreenWidth(100),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Stack(
//               children: [
//                 Image.asset(
//                   image,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         const Color(0xFF343434).withOpacity(0.4),
//                         const Color(0xFF343434).withOpacity(0.15),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenWidth(15.0),
//                     vertical: getProportionateScreenWidth(10),
//                   ),
//                   child: Text.rich(
//                     TextSpan(
//                       style: const TextStyle(color: Colors.white),
//                       children: [
//                         TextSpan(
//                           text: "$category\n",
//                           style: TextStyle(
//                             fontSize: getProportionateScreenWidth(18),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(text: "$numOfBrands Brands")
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
