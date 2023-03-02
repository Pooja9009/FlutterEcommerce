import 'package:get/get.dart';

class Dimensions {
  // accessing height and width properties
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // Main Screen size adjusting (screen siz/ 320)
  static double pageView = screenHeight / 2.64;
  // container size adjusting
  static double pageViewContainer = screenHeight / 3.84;
  // Text container size adjusting
  static double pageViewTextContainer = screenHeight / 6.5;

  // dynamic height for padding and margin
  static double height5 = screenHeight / 168.5;
  static double height8 = screenHeight / 105.5;
  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 42.2;
  static double height22 = screenHeight / 38.36;
  static double height25 = screenHeight / 33.76;
  static double height15 = screenHeight / 56.27;
  static double height30 = screenHeight / 28.13;
  static double height35 = screenHeight / 23.53;
  static double height40 = screenHeight / 21.1;
  static double height45 = screenHeight / 18.76;
  static double height50 = screenHeight / 16.88;
  static double height60 = screenHeight / 13.33;
  static double height65 = screenHeight / 12.98;
  static double height70 = screenHeight / 10.78;
  static double height100 = screenHeight / 8.44;
  static double height150 = screenHeight / 5.61;
  static double height300 = screenHeight / 2.81;
  static double height245 = screenHeight / 3.44;

  //
  // static double height300 = screenHeight / 2.63;
  static double height225 = screenHeight / 3.44;

  // dynamic width for padding and margin
  static double width2 = screenHeight / 422;
  static double width5 = screenHeight / 168.8;
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width25 = screenHeight / 33.76;
  static double width30 = screenHeight / 28.13;
  static double width35 = screenHeight / 23.53;
  static double width70 = screenHeight / 12.98;
  static double width75 = screenHeight / 11.25;
  static double width81 = screenHeight / 10.41;
  static double width85 = screenHeight / 9.92;
  static double width100 = screenHeight / 8.44;
  static double width150 = screenHeight / 5.61;
  static double width130 = screenHeight / 6.49;
  static double width200 = screenHeight / 4.22;

  // Font and Icon size (screen size / icon or font size)
  static double font20 = screenHeight / 42.2;
  static double font12 = screenHeight / 70.3;
  static double font14 = screenHeight / 60.28;
  static double font15 = screenHeight / 56.26;
  static double font17 = screenHeight / 49.64;
  static double font26 = screenHeight / 32.46;
  static double font30 = screenHeight / 28.13;
  static double space2 = screenWidth / 422;
  // static double icon20 = screenHeight / 42.2;

  // Radius Size adjusting
  static double radius10 = screenHeight / 84.4;
  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;
  static double radius50 = screenHeight / 16.88;

  // default icon size converting to dynamic
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize27 = screenHeight / 31.25;
  static double iconSize16 = screenHeight / 52.75;
  static double iconSize20 = screenHeight / 42.2;

  // list view size
  static double listViewImgSize = screenHeight / 6.02;
  static double listViewTextContSize = screenHeight / 6.02;

  // Popular food
  static double popularFoodImageSize = screenHeight / 2.42;

  // bottom height
  static double bottomHeightBar = screenHeight / 7.03;
}
