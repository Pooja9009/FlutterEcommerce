import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:techies_battle/app/utils/notification.dart';
import 'package:techies_battle/components/default_button.dart';
import 'package:techies_battle/components/rounded_icon_btn.dart';
import 'package:techies_battle/constants.dart';
import 'package:techies_battle/data/remote_data_source/response/single_product_response.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/repository/remote_repository/cart_repository.dart';
import 'package:techies_battle/repository/remote_repository/product_repository.dart';
import 'package:techies_battle/screens/cart/components/cart_screen.dart';
import 'package:techies_battle/screens/details/components/custom_app_bar.dart';
import 'package:techies_battle/screens/widget/snack_bar.dart';
import 'package:techies_battle/size_config.dart';

import 'top_rounded_container.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? receivedProductId;
  final String? receivedProductPrice;
  final String? receivedFoodName;
  const ProductDetailScreen(
      {Key? key,
      required this.receivedProductId,
      required this.receivedProductPrice,
      required this.receivedFoodName})
      : super(key: key);
  static String routeName = "/productDetails";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int? productPrice = 0;
  int? selectedImage = 0;

  int qty = 1;

  bool isAddedToCart = false;

  bool isCartDelete = false;

  addToCart(String foodId, String quantity) async {
    final isNewItemAddedToCart =
        await CartRepository().addProductToCart(foodId, quantity);
    return isNewItemAddedToCart;
  }

  deleteProductFromCart(String foodId) async {
    final isDeleted = await CartRepository().deleteProductFromCart(foodId);
    return isDeleted;
  }

  @override
  void initState() {
    getProductDetail();
    productPrice = int.parse(widget.receivedProductPrice!);
    super.initState();
  }

  int getTotalAmt(int foodPrice, int qty) {
    return foodPrice * qty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F6F9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(rating: 2.3),
        ),
        body: getProductDetail());
  }

  FutureBuilder<SingleProductResponse?> getProductDetail() {
    return FutureBuilder<SingleProductResponse?>(
        future: ProductRepository().getSingleProduct(widget.receivedProductId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Product? productData = snapshot.data!.data!;
            productPrice = int.parse(productData.price);
            print("The Food: -->${productData.title}");
            return ListView(
              children: [
                // Product Image
                Column(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(238),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(productData.foodPhoto[0]),
                      ),
                    ),
                  ],
                ),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: Text(
                              productData.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(15)),
                              width: getProportionateScreenWidth(64),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Heart Icon_2.svg",
                                color: const Color(0xFFDBDEE4),
                                height: getProportionateScreenWidth(16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(20),
                              right: getProportionateScreenWidth(64),
                            ),
                            child: Text(
                              productData.description,
                              maxLines: 5,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: const [
                                  Text(
                                    "See More Detail",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      TopRoundedContainer(
                        color: const Color(0xFFF6F7F9),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: Row(
                                children: [
                                  Text("Rs.${productData.price}",
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.red)),
                                  const Spacer(),
                                  RoundedIconBtn(
                                    icon: Icons.remove,
                                    press: () {
                                      setState(() {
                                        qty > 1
                                            ? qty -= 1
                                            : showSnackbar(
                                                context,
                                                "1 Items Must be selected",
                                                Colors.red);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(20)),
                                  Text(
                                    "$qty",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(20)),
                                  RoundedIconBtn(
                                    icon: Icons.add,
                                    showShadow: true,
                                    press: () {
                                      setState(() {
                                        qty += 1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            TopRoundedContainer(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.15,
                                  right: SizeConfig.screenWidth * 0.15,
                                  bottom: getProportionateScreenWidth(40),
                                  top: getProportionateScreenWidth(15),
                                ),
                                child: DefaultButton(
                                  text: "Add To Cart",
                                  press: () async {
                                    await addToCart(widget.receivedProductId!,
                                        qty.toString());
                                    // showAlert();
                                    MyNotification.showNotification(
                                        notificationTitle: "Techies battle",
                                        notificationMessage:
                                            "${widget.receivedFoodName!} Add to Cart Successfully");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.green,
                                          content: const Text(
                                            "Item added to cart Successfully",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          action: SnackBarAction(
                                              label: "View Cart",
                                              textColor: Colors.white,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            const CartScreen()));
                                              })),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  // Image List
  GestureDetector buildSmallProductPreview(int index, productData) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(productData.foodPhoto[0]),
      ),
    );
  }

  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Your order placed successfully',
      confirmBtnColor: kPrimaryColor,
      confirmBtnText: 'View Cart',
      autoCloseDuration: const Duration(seconds: 2),
      onConfirmBtnTap: () {
        // Navigator.pop(context);
        Navigator.pushNamed(context, CartScreen.routeName);
      },
    );
  }
}
