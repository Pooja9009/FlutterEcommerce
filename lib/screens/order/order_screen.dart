import 'package:flutter/material.dart';
import 'package:techies_battle/screens/order/component/canceled_order.dart';
import 'package:techies_battle/screens/order/component/complete_order.dart';
import 'package:techies_battle/screens/order/component/pending_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static String routeName = "/order";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  List<String> categories = ["Active", "Completed", "Canceled"];
  TabController? _tabController;
  int selectedIndex = 0;
  final _tabViewChildren = [
    const OrderActivePage(),
    const OrderCompletedPage(),
    const OrderCancelledPage()
  ];

  @override
  void initState() {
    _tabController =
        TabController(length: _tabViewChildren.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              "Orders History",
              style: TextStyle(color: Colors.black),
            )),
        toolbarHeight: 45,
        centerTitle: true,
        // implement the tab bar
        bottom: TabBar(
          indicatorColor: Colors.green,
          controller: _tabController,
          onTap: (selectedTab) {
            setState(() {
              selectedIndex = selectedTab;
            });
            print("the selected index: --> $selectedIndex");
          },
          tabs: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Active",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: setColor(0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Complete",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: setColor(1)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Canceled",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: setColor(2)),
              ),
            ),
            // Tab(
            //   icon: Icon(Icons.shop),
            // ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // implement the tab view
          TabBarView(
            controller: _tabController,
            children: _tabViewChildren,
          ),
          // implement the dots indicator
        ],
      ),
    );
  }

  Color setColor(int tabIndex) {
    return selectedIndex == tabIndex ? Colors.green : Colors.black;
  }
}
