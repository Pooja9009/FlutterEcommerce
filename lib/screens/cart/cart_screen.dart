// import 'package:flutter/material.dart';
// import 'package:shop_app/model/CartModel.dart';

// import 'components/cart_screen.dart';
// import 'components/check_out_card.dart';

// class CartScreen extends StatelessWidget {
//   static String routeName = "/cart";

//   const CartScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: Body(),
//       bottomNavigationBar: const CheckoutCard(),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       title: Column(
//         children: [
//           const Text(
//             "Your Cart",
//             style: TextStyle(color: Colors.black),
//           ),
//           Text(
//             "${demoCarts.length} items",
//             style: Theme.of(context).textTheme.bodySmall,
//           ),
//         ],
//       ),
//     );
//   }
// }
