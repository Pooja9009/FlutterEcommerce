import 'package:flutter/widgets.dart';
import 'package:techies_battle/components/dashboard.dart';
import 'package:techies_battle/screens/cart/components/cart_screen.dart';
import 'package:techies_battle/screens/checkout/checkout_screen.dart';
import 'package:techies_battle/screens/complete_profile/complete_profile_screen.dart';
import 'package:techies_battle/screens/forgot_password/forgot_password_screen.dart';
import 'package:techies_battle/screens/home/components/category_detail.dart';
import 'package:techies_battle/screens/home/components/search_screen.dart';
import 'package:techies_battle/screens/home/home_screen.dart';
import 'package:techies_battle/screens/order/component/order_product.dart';
import 'package:techies_battle/screens/order/order_screen.dart';
import 'package:techies_battle/screens/otp/otp_screen.dart';
import 'package:techies_battle/screens/profile/components/change_password.dart';
import 'package:techies_battle/screens/profile/components/update_profile.dart';
import 'package:techies_battle/screens/profile/profile_screen.dart';
import 'package:techies_battle/screens/sign_in/sign_in_screen.dart';
import 'package:techies_battle/screens/splash/splash_screen.dart';
import 'package:techies_battle/screens/wearOS/component/wearOs_dashboard.dart';
import 'package:techies_battle/screens/wearOS/component/wearOs_login.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  DashboardScreen.routeName: (context) => const DashboardScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  // LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  // ProductDetailScreen.routeName: (context) => const ProductDetailScreen(   ),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  UpdateProfileScreen.routeName: (context) => const UpdateProfileScreen(),
  ChangePasswordScreen.routeName: (context) => const ChangePasswordScreen(),
  CheckoutScreen.routeName: (context) => const CheckoutScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  OrderProduct.routeName: (context) => const OrderProduct(),
  SearchScreen.routeName: (context) => const SearchScreen(),
  CategoryItems.routeName: (context) => const CategoryItems(),
  WearOsLoginScree.routeName: (context) => const WearOsLoginScree(),
  WearOsDashboard.routeName: (context) => const WearOsDashboard(),
};
