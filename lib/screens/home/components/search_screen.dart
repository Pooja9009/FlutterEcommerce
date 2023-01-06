import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:techies_battle/constants.dart';
import 'package:techies_battle/data/remote_data_source/response/product_response.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/repository/remote_repository/product_repository.dart';
import 'package:techies_battle/screens/details/components/productDetail.dart';
import 'package:techies_battle/size_config.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = "/searchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    getAllProduct();
    super.initState();
  }

  List<Product> originalFoodList = [];
  List<Product> searchedFoodList = [];

  void _searchProduct(String searchTypedText) {
    List<Product> searchResultFound = [];
    if (searchTypedText.isNotEmpty) {
      searchResultFound = originalFoodList.where((food) {
        String productNameInSmallCase = food.title.toLowerCase();
        String searchTypedTextInSmallCase = searchTypedText.toLowerCase();
        return productNameInSmallCase.contains(searchTypedTextInSmallCase);
      }).toList();
    } else {
      searchResultFound = originalFoodList;
    }
    setState(() {
      searchedFoodList = searchResultFound;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    onChanged: (value) => _searchProduct(value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenWidth(9)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: kPrimaryColor, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: kPrimaryColor, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      // border: Border.all(
                      //   color: kPrimaryColor,
                      //   width: getProportionateScreenWidth(1),
                      // ),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      hintText: "Search product",
                      prefixIcon: const Icon(
                        LineAwesomeIcons.search,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: getAllProduct()),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<ProductResponse?> getAllProduct() {
    return FutureBuilder<ProductResponse?>(
        future: ProductRepository().getAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data!.isNotEmpty) {
            List<Product>? foodList = snapshot.data!.data!;
            originalFoodList = foodList;
            if (searchedFoodList.isEmpty) {
              searchedFoodList = foodList;
            }
            return ListView.builder(
                itemCount: searchedFoodList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                  receivedProductId: searchedFoodList[index].id,
                                  receivedProductPrice:
                                      searchedFoodList[index].price,
                                  receivedFoodName:
                                      searchedFoodList[index].title)));
                    },
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.all(getProportionateScreenHeight(3)),
                            child: SizedBox(
                              width: getProportionateScreenHeight(90),
                              height: getProportionateScreenHeight(90),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(10)),
                                child: Image.network(
                                  searchedFoodList[index].foodPhoto[0],
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenHeight(10),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: getProportionateScreenHeight(250),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(searchedFoodList[index].title),
                                    Text(
                                      "Rs. ${searchedFoodList[index].price}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(18),
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              SizedBox(
                                width: getProportionateScreenHeight(250),
                                child: Text(
                                  searchedFoodList[index].description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
