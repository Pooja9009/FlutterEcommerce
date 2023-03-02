import 'package:flutter/material.dart';
import 'package:techies_battle/app/constraint/app_url.dart';

class PaymentScreen extends StatefulWidget {
  String? selectedPaymentMethod;

  PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedIndex = 1;
  String getSelectedValue() {
    String paymentMethod = 'Cash On Delivery';
    if (selectedIndex == 1) {
      paymentMethod = "Cash On Delivery";
    } else if (selectedIndex == 2) {
      paymentMethod = "Khalti";
    } else if (selectedIndex == 3) {
      paymentMethod = "Esewa";
    }
    getSelectedPaymentMethod = paymentMethod;
    return paymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                        getSelectedValue();
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          value: selectedIndex,
                          groupValue: 1,
                          autofocus: true,
                          onChanged: (value) {
                            setState(() {
                              selectedIndex = 1;
                              getSelectedValue();
                            });
                          },
                        ),
                        const Text(
                          'Cash on Delivery',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(Icons.money, size: 20),
                      ],
                    ),
                  ),
                  const Text(
                    'Pay with cash upon delivery',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                  getSelectedValue();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Radio(
                          value: selectedIndex,
                          groupValue: 2,
                          onChanged: (value) {
                            setState(() {
                              selectedIndex = 2;
                              getSelectedValue();
                            });
                          },
                        ),
                        const Text('Khalti Digital \nWallet',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(
                          width: 15,
                        ),
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              "https://res.cloudinary.com/dymp3ozdm/image/upload/v1676926243/foodex/Logo/khalti-removebg-preview_sx6sbt.png"),
                        ),
                      ],
                    ),
                    const Text(
                      'Pay online using Khalti \nDigital Wallet',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                  getSelectedValue();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: selectedIndex,
                          groupValue: 3,
                          onChanged: (value) {
                            setState(() {
                              selectedIndex = 3;
                              getSelectedValue();
                            });
                          },
                        ),
                        const Text('eSewa',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(
                          width: 15,
                        ),
                        const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              "https://res.cloudinary.com/dymp3ozdm/image/upload/v1676926067/foodex/Logo/esewa_p5x3o4.png"),
                        ),
                      ],
                    ),
                    const Text(
                      'Pay using eSewa digital wallet',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
