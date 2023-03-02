import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techies_battle/constants.dart';
import 'package:techies_battle/data/remote_data_source/response/cart_response.dart';
import 'package:techies_battle/model/cart.dart';
import 'package:techies_battle/no_net/no_internet.dart';
import 'package:techies_battle/repository/remote_repository/cart_repository.dart';
import 'package:techies_battle/size_config.dart';

class OrderProduct extends StatefulWidget {
  const OrderProduct({Key? key}) : super(key: key);
  static String routeName = "/order_detail";

  @override
  State<OrderProduct> createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  List<Cart> cartList = [];
  int? totalAmount = 0;
  List<Cart> cartListForTotalAmt = [];
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "items",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: getAllCart()),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(15),
                  horizontal: getProportionateScreenWidth(30),
                ),
                // height: 174,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -15),
                      blurRadius: 20,
                      color: const Color(0xFFDADADA).withOpacity(0.15),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(150),
                        height: getProportionateScreenHeight(56),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Cancel order",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(150),
                        height: getProportionateScreenHeight(56),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Cancel order",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  FutureBuilder<CartResponse?> getAllCart() {
    return FutureBuilder<CartResponse?>(
        future: CartRepository().getAllCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cartList = snapshot.data!.data!;
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(cartList[index].foodId.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() async {
                      // cartList.removeAt(index);
                      List<Cart> cloneCartList = cartList;
                      final result = await CartRepository()
                          .deleteProductFromCart(cartList[index].foodId!.id!);
                      if (result == true) {
                        cartList.removeAt(
                          cloneCartList.length - 1,
                        );
                        setState(() {
                          cartList = cloneCartList;
                          // setTotalCartAmt();
                        });
                      }
                    });
                  },
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 88,
                        child: AspectRatio(
                          aspectRatio: 0.88,
                          child: Container(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(10)),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.network(
                                cartList[index].foodId!.foodPhoto[0]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartList[index].foodId!.title,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: "\$${cartList[index].foodId!.price}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                              children: [
                                TextSpan(
                                    text: " x${cartList[index].quantity}",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
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
