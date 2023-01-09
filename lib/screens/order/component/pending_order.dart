import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/app/utils/notification.dart';
import 'package:techies_battle/constants.dart';
import 'package:techies_battle/data/remote_data_source/response/order_response.dart';
import 'package:techies_battle/model/order.dart';
import 'package:techies_battle/repository/remote_repository/order_repository.dart';
import 'package:techies_battle/screens/widget/snack_bar.dart';
import 'package:techies_battle/size_config.dart';

class OrderActivePage extends StatefulWidget {
  const OrderActivePage({Key? key}) : super(key: key);

  @override
  State<OrderActivePage> createState() => _OrderActivePageState();
}

class _OrderActivePageState extends State<OrderActivePage> {
  List<Order> orderList = [];
  String generateOrderId(String orderId) {
    String lastFiveChar = orderId.substring(orderId.length - 5);
    return lastFiveChar;
  }

  @override
  Widget build(BuildContext context) {
    return getAllOrder();
  }

  FutureBuilder<OrderResponse?> getAllOrder() {
    return FutureBuilder<OrderResponse?>(
        future: OrderRepository().getAllOrder(ORDER_PENDING),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            orderList = snapshot.data!.data!;
            for (var order in orderList) {
              print("The order is:-->${order.foodId}");
            }
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
                                SizedBox(
                                  width: getProportionateScreenWidth(100),
                                  height: getProportionateScreenHeight(40),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: const BorderSide(color: Colors.red),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      // backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      showAlertDialog(
                                          context, orderList[index].id!);
                                    },
                                    child: Center(
                                      child: Text(
                                        "Cancel order",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(13),
                                            color: Colors.red,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
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
                                              color: Colors.green),
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
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void showAlertDialog(BuildContext context, String orderId) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Cancel order",
      desc: "Do you want to cancel this Order?",
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await OrderRepository().cancelOrder(orderId);
        MyNotification.showNotification(
            notificationTitle: "Order Cancel",
            notificationMessage: "Your oder has been cancelled");
        showSnackbar(context, "Order Cancelled Successfully", Colors.green);
      },
    ).show();
  }

  // void showAlertDialog(BuildContext context, String orderId) {
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.warning,
  //     title: "Cancel Order?",
  //     text: 'Do you want to cancel your order?',
  //     confirmBtnText: 'conform',
  //     cancelBtnText: 'Cancel',
  //     confirmBtnColor: Colors.green,
  //     onCancelBtnTap: () {},
  //     onConfirmBtnTap: () async {
  //       final result = await OrderRepository().cancelOrder(orderId);
  //       if (result == true) {
  //         showSnackbar(context, "Order Cancelled Successfully", Colors.green);
  //       }
  //     },
  //     // cancelBtnColor: Colors.red,
  //   );
}
