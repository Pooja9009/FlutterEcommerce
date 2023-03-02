import 'package:flutter/material.dart';
import 'package:techies_battle/model/cart.dart';
import 'package:techies_battle/repository/remote_repository/cart_repository.dart';

class TotalAmount extends StatefulWidget {
  const TotalAmount({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalAmount> createState() => _TotalAmountState();
}

class _TotalAmountState extends State<TotalAmount> {
  List<Cart> cartList = [];
  int? totalAmount = 0;
  List<Cart> cartListForTotalAmt = [];
  int? deliveryFee = 50;
  int? totalAmountWithDeliveryFee = 0;
  int? vat = 0;

  // @override
  // void initState() {
  //   setTotalCartAmt();
  //   setFinalAmount();
  //   super.initState();
  // }

  // void setTotalCartAmt() async {
  //   int? myTotalAmount = 0;
  //   final allCart = await CartRepository().getAllCart();
  //   cartListForTotalAmt = allCart!.data!;
  //   List<int> myAmountList = [];
  //   for (Cart i in cartListForTotalAmt) {
  //     int productAmount = int.parse(i.foodId!.price) * i.quantity!;
  //     myAmountList.add(productAmount);
  //   }
  //   for (int i in myAmountList) {
  //     myTotalAmount = myTotalAmount! + i;
  //   }
  //   setState(() {
  //     totalAmount = myTotalAmount;
  //   });
  // }

  // void setFinalAmount() async {
  //   int? myTotalAmount = 0;
  //   final allCart = await CartRepository().getAllCart();
  //   cartListForTotalAmt = allCart!.data!;
  //   List<int> myAmountList = [];
  //   for (Cart i in cartListForTotalAmt) {
  //     int productAmount = int.parse(i.foodId!.price) * i.quantity!;
  //     myAmountList.add(productAmount);
  //   }
  //   for (int i in myAmountList) {
  //     myTotalAmount = myTotalAmount! + i;
  //   }
  //   setState(() {
  //     totalAmountWithDeliveryFee = myTotalAmount + deliveryFee! + vat!;
  //   });
  // }

  // List<Cart> cartList = [];
  // int? totalAmount = 0;
  // List<Cart> cartListForTotalAmt = [];
  // int? deliveryFee = 50;
  // int? totalAmountWithDeliveryFee = 0;
  @override
  void initState() {
    setTotalCartAmt();
    setFinalAmount();
    super.initState();
  }

  void setTotalCartAmt() async {
    int? myTotalAmount = 0;
    final allCart = await CartRepository().getAllCart();
    cartListForTotalAmt = allCart!.data!;
    List<int> myAmountList = [];
    for (Cart i in cartListForTotalAmt) {
      int productAmount = int.parse(i.foodId!.price) * i.quantity!;
      myAmountList.add(productAmount);
    }
    for (int i in myAmountList) {
      myTotalAmount = myTotalAmount! + i;
    }
    setState(() {
      totalAmount = myTotalAmount;
    });
  }

  void setFinalAmount() async {
    int? myTotalAmount = 0;
    final allCart = await CartRepository().getAllCart();
    cartListForTotalAmt = allCart!.data!;
    List<int> myAmountList = [];
    for (Cart i in cartListForTotalAmt) {
      int productAmount = int.parse(i.foodId!.price) * i.quantity!;
      myAmountList.add(productAmount);
    }
    for (int i in myAmountList) {
      myTotalAmount = myTotalAmount! + i;
    }
    setState(() {
      vat = myTotalAmount! * 13 ~/ 100;

      totalAmountWithDeliveryFee = myTotalAmount + deliveryFee! + vat!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sub Total",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Rs. $totalAmount",
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "VAT",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Rs. ${totalAmount! * 13 ~/ 100}",
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Delivery Charge",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Rs. $deliveryFee",
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Grand Total",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Rs. $totalAmountWithDeliveryFee",
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ]),
    ));
  }
}
