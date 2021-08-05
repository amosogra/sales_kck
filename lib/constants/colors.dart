



import 'package:flutter/material.dart';

class MyColors {
  MyColors._(); // this basically make it so you can't instantiate this class.

  static const primaryColor = Color(0xFF008BA2);
  static final blueColor = Color(0xFF1D3DB1);
  static const greenColor =  Color(0xFF009e39);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const bgColor =  Color(0xfff2f9ff);

  static const Map<int, Color> orange = const<int, Color>{
      100: const Color(0xFFFCF2E7),
      200: const Color(0xFFF8DEC3),
  };

}