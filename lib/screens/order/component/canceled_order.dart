import 'dart:io';

import 'package:flutter/material.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/constants.dart';
import 'package:techies_battle/data/remote_data_source/response/order_response.dart';
import 'package:techies_battle/model/order.dart';
import 'package:techies_battle/no_net/no_internet.dart';
import 'package:techies_battle/repository/remote_repository/order_repository.dart';


class OrderCancelledPage extends StatefulWidget {
  const OrderCancelledPage({Key? key}) : super(key: key);

  @override
  State<OrderCancelledPage> createState() => _OrderCancelledPageState();
}

class _OrderCancelledPageState extends State<OrderCancelledPage> {
  List<Order> orderList = [];

  @override
  Widget build(BuildContext context) {
    return getAllOrder();
  }

  FutureBuilder<OrderResponse?> getAllOrder() {
    return FutureBuilder<OrderResponse?>(
        future: OrderRepository().getAllOrder(ORDER_CANCELLED),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            orderList = snapshot.data!.data!;
            return ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  orderList[index].foodId!.title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                // SizedBox(
                                //   width: getProportionateScreenWidth(100),
                                //   height: getProportionateScreenHeight(40),
                                //   child: TextButton(
                                //     style: TextButton.styleFrom(
                                //       foregroundColor: Colors.white,
                                //       side: const BorderSide(color: Colors.red),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(20)),
                                //       // backgroundColor: Colors.red,
                                //     ),
                                //     onPressed: () {},
                                //     child: Center(
                                //       child: Text(
                                //         "Cancelled",
                                //         style: TextStyle(
                                //             fontSize:
                                //                 getProportionateScreenWidth(13),
                                //             color: Colors.red,
                                //             fontWeight: FontWeight.w700),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                "$getCurrentLocation",
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              color: kPrimaryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text("Order No."),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            "#${generateOrderId(orderList[index].id!)}"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("QTY: "),
                                        const SizedBox(
                                          width: 38,
                                        ),
                                        Text(
                                            "Rs. ${orderList[index].orderedQty}"),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text("Total"),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Rs. ${orderList[index].totalPrice!}",
                                          style: const TextStyle(
                                              color: kTextColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Status"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          orderList[index]
                                              .deliveryStatusMessage!,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          if (NetworkInterface.listSupported) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const NoInternet();
          }
        });
  }

  String generateOrderId(String orderId) {
    String lastFiveChar = orderId.substring(orderId.length - 5);
    return lastFiveChar;
  }
}
