import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:techies_battle/app/constraint/app_url.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/app/utils/notification.dart';
import 'package:techies_battle/repository/remote_repository/order_repository.dart';
import 'package:techies_battle/screens/checkout/component/address.dart';
import 'package:techies_battle/screens/checkout/component/payment.dart';
import 'package:techies_battle/screens/checkout/component/title.dart';
import 'package:techies_battle/screens/checkout/component/total_amount.dart';
import 'package:techies_battle/screens/home/home_screen.dart';
import 'package:techies_battle/screens/profile/widget/color_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);
  static String routeName = "/checkout";

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String location = '';
  String address = '';

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      Placemark place = placemarks[0];
      address =
          '${place.subLocality}, ${place.thoroughfare}, ${place.locality}, ${place.postalCode}, ${place.country}';
      getCurrentLocation = address;
    });
  }

  void setAddress() async {
    final Position position = await getGeoLocationPosition();
    setState(() {
      getAddressFromLatLong(position);
    });
  }

  @override
  void initState() {
    setAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleName(
                hintText: "DELIVERY ADDRESS",
              ),
              const SizedBox(
                height: 10,
              ),
              const AddressScreen(),
              const SizedBox(
                height: 10,
              ),
              const TitleName(
                hintText: "PAYMENT METHOD ",
              ),
              const SizedBox(
                height: 10,
              ),
              PaymentScreen(),
              const SizedBox(
                height: 10,
              ),
              const TitleName(
                hintText: "AMOUNT",
              ),
              const SizedBox(
                height: 10,
              ),
              const TotalAmount(),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                      child: Text(
                        "Place Order".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      showAlertDialog(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        isScrollControlled: true,
        // useSafeArea: false,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.3,
            child: Padding(
              padding: const EdgeInsets.all(20 + 5),
              child: Column(
                children: [
                  const Text(
                    "Confirm your order with",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    getSelectedPaymentMethod!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () async {
                            final result =
                                await OrderRepository().addProductToOrder();
                            if (getSelectedPaymentMethod ==
                                "Cash On Delivery") {
                              setPaymentMethod(getSelectedPaymentMethod!);
                            } else {
                              setPaymentMethod(getSelectedPaymentMethod!);
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text("Confirm")),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                          label: const Text("Cancel")),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void setPaymentMethod(String selectedPaymentMethod) {
    print(selectedPaymentMethod);
    if (getSelectedPaymentMethod == "Cash On Delivery") {
      showAlert();
      MyNotification.showNotification(
          notificationTitle: "Order Placed",
          notificationMessage: "Your oder has been placed successfully");
    } else if (getSelectedPaymentMethod == "Khalti") {
      khaltiWallet();
      // MyNotification.showNotification(
      //     notificationTitle: "Order Placed",
      //     notificationMessage: "Your oder has been placed successfully");
    } else {
      print("From esewa");
    }
  }

  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Your order placed successfully',
      autoCloseDuration: const Duration(seconds: 2),
      onConfirmBtnTap: () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      },
      // onCancelBtnTap: () {},
    );
  }

  // void showConformAlert() {
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.confirm,
  //     title: "Conform Order?",
  //     text: 'Conform your order \nwith Cash?',
  //     confirmBtnText: 'Conform',
  //     cancelBtnText: 'Cancel',
  //     confirmBtnColor: Colors.green,
  //     onConfirmBtnTap: () {
  //       showAlert();
  //     },

  //     // cancelBtnColor: Colors.red,
  //   );
  // }

  // Khalti
  khaltiWallet() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "1",
          productName: "nike blazers mid 77",
          mobile: "9808792437"),
      preferences: [PaymentPreference.khalti],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCanceled,
    );
  }

  // method to handle success
  void onSuccess(PaymentSuccessModel success) {
    QuickAlert.show(
      autoCloseDuration: const Duration(seconds: 3),
      context: context,
      type: QuickAlertType.success,
      text: 'Your order placed successfully',
      onConfirmBtnTap: () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      },
      // onCancelBtnTap: () {},
    );
  }

  // method to handle failure
  void onFailure(PaymentFailureModel failure) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Failure"),
            content: const Text("Payment failed"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  // method to handle onCanceled
  void onCanceled() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Canceled"),
            content: const Text("Payment canceled"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }
}
