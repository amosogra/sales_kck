



import 'package:flutter/material.dart';

class MyColors {
  MyColors._(); // this basically make it so you can't instantiate this class.

  //static const primaryColor = Color(0xFF008BA2);
  static const primaryColor = Color(0xFFFF6700);
  static final blueColor = Color(0xFF1D3DB1);
  static const greenColor =  Color(0xFF009e39);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const bgColor =  Color(0xfff2f9ff);
  static const greyColor = Color(0xffdddddd);

  static const textBorderColor = Color(0xFFCECECE);
  static const textColor = Color(0xFF020202);
  static const textGreyColor = Color(0xFF7B7B7C);

  static const Map<int, Color> orange = const<int, Color>{
      100: const Color(0xFFFCF2E7),
      200: const Color(0xFFF8DEC3),
  };

  static const MaterialColor materialPrimaryColor = const MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xFFFF6700 ),//10%
      100: const Color(0xFFFF6700),//20%
      200: const Color(0xFFFF6700),//30%
      300: const Color(0xFFFF6700),//40%
      400: const Color(0xFFFF6700),//50%
      500: const Color(0xFFFF6700),//60%
      600: const Color(0xFFFF6700),//70%
      700: const Color(0xFFFF6700),//80%
      800: const Color(0xFFFF6700),//90%
      900: const Color(0xFFFF6700),//100%
    },
  );


}