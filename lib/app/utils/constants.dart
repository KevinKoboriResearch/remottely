import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
// import 'package:universal_platform/universal_platform.dart';

class AppURLs {
  static const BASE_API_URL = 'https://remottely-key-firebase.firebaseio.com';
}

// class AppKey {
//   static const IOS_GOOGLE_API_KEY =
//       'AIzaSyAt6woNZOsFEM23VuhP-tY59I3QAEcwE_0';
//   static const ANDROID_GOOGLE_API_KEY =
//       'AIzaSyAy-rnrKZAAbtePw0ynMwdQORieCYwKZg8';
//   static const WEB_GOOGLE_API_KEY =
//       'AIzaSyCQUTrZVXRzlR1WK5Xe0deTawiP0urxfpg';
//   static String get detectGoogleApi =>
//       kIsWeb ? WEB_GOOGLE_API_KEY : UniversalPlatform.isAndroid ? ANDROID_GOOGLE_API_KEY : IOS_GOOGLE_API_KEY;
// }

class AppColors {
  static const Color astronautCanvasColor = Colors.white; //Color(0XFFe5eff9);
  static const Color astronautConvexColor = Colors.white; //Color(0XFFe8f0f8);
  static const Color astronautConcaveColor = Colors.white; //Color(0XFFe3ecf5);
  static Color astronautDarkBlueColor = Colors.grey[800];//Color(0XFF334368);
  // static const Color astronautOrangeColor = Color(0XFFff5823);
  static const Color astronautOrangeColor = Color(0XFFfc7a09);
  static const Color astronautOrangeDarkColor = Color(0XFFf05102);
  static const Color astratosDarkGreyColor = Colors.black; //Color(0XFF1b1f22);
  static const Color astratosGreyColor = Color(0XFF46494e);
  static const Color astratosLightGreyColor = Color(0XFFe1e6ec);
  static const Color astratosGreenColor = Color(0XFF53b96f);
  static const Color astratosBlueColor = Color(0XFF0cb4d4);
  static const Color astratosRedColor = Color(0XFFed523c);

  static const Color textColor = astratosDarkGreyColor; //astratosGreyColor;
  static const Color subTextColor = Colors.grey;
  static const Color indicatorColor =
      Color(0XFF1fd38f); //AppColors.blueColor; //Color(0XFF616d72);
  // static const Color textColor = Colors.white;
  static const Color accentColor = AppColors.astronautOrangeColor;
  // static const Color accentColor = Color(0XFFfc7a09);
  // AppColors.blueColor; //Color(0XFF286ef0); //AppColors.blueColor;
  static const Color buttonColor = Color(0XFF00B4CC);
  static const Color cardColor = Color(0XFFffffff);
  static const Color canvasColor = Color(0XFF28292b);
  // static const Color canvasColor = Color(0XFF212528);
  // static const Color primaryColor = Color(0XFF10171f);
  static const Color primaryColor =
      AppColors.textColor; //Color(0XFF4c4d51); //Color(0XFF36373a);
  static const Color blueColor = Color(0XFF0c99c3);
  static const Color greenColor = Color(0XFF3dc39d);
  static const Color yellowColor = Color(0XFFdac007);
  static const Color redColor = Color(0XFFbe0b2b);
  static const Color orangeColor = Color(0XFFef6e00);
  static const Color pinkColor = Color(0XFFdb3380);
  static const Color purpleColor = Color(0XFF9146ff);
  static const Color indigoColor = Color(0XFF5872f5);
  static const Color greyColor = Color(0XFFa2adb9);
  static const Color darkGreyColor =
      Color(0XFF43474c); //nao pode entrar em eventos
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black; //nao pode entrar em eventos
}
