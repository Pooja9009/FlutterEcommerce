import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:techies_battle/constants.dart';
import 'package:techies_battle/data/remote_data_source/response/product_response.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/repository/remote_repository/product_repository.dart';
import 'package:techies_battle/screens/details/components/productDetail.dart';
import 'package:techies_battle/size_config.dart';

class CategoryItems extends StatefulWidget {
  final String? productCategoryTitle;
  final String? productCategoryId;
  const CategoryItems({
    Key? key,
    this.productCategoryTitle,
    this.productCategoryId,
  }) : super(key: key);
  static String routeName = "/category";

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  String categoryTitle = "";

  @override
  void initState() {
    // getAllFood();
    categoryTitle = widget.productCategoryId!;
    getAllCategoryProduct();
    super.initState();
  }

  List<Product> originalProductList = [];
  List<Product> searchedProductList = [];
  final TextEditingController _searchController = TextEditingController();

  void _searchProduct(String searchTypedText) {
    List<Product> searchResultFound = [];
    if (searchTypedText.isNotEmpty) {
      searchResultFound = originalProductList.where((food) {
        String productNameInSmallCase = food.title.toLowerCase();
        String searchTypedTextInSmallCase = searchTypedText.toLowerCase();
        return productNameInSmallCase.contains(searchTypedTextInSmallCase);
      }).toList();
    } else {
      searchResultFound = originalProductList;
    }
    setState(() {
      searchedProductList = searchResultFound;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.productCategoryTitle!,
            style: const TextStyle(color: Colors.black),
          ),
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
                    controller: _searchController,
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
                      hintText: "Search product",
                      prefixIcon: const Icon(
                        LineAwesomeIcons.search,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: getAllCategoryProduct()),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<ProductResponse?> getAllCategoryProduct() {
    return FutureBuilder<ProductResponse?>(
        future: ProductRepository().getAllProductCategory(categoryTitle),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data!.isNotEmpty) {
            List<Product>? productList = snapshot.data!.data!;
            originalProductList = productList;
            if (searchedProductList.isEmpty) {
              searchedProductList = productList;
            }
            return ListView.builder(
                itemCount: searchedProductList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                  receivedProductId:
                                      searchedProductList[index].id,
                                  receivedProductPrice:
                                      searchedProductList[index].price,
                                  receivedFoodName:
                                      searchedProductList[index].title)));
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
                                  searchedProductList[index].foodPhoto[0],
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
                                    Text(searchedProductList[index].title),
                                    Text(
                                      "Rs. ${searchedProductList[index].price}",
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
                                  searchedProductList[index].description,
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
