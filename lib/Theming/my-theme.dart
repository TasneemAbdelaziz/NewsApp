import 'dart:ui';

import 'package:flutter/material.dart';

class myTheme{
  static Color primaryLight = Color(0xff39A552);
  static Color whitColor = Color(0xffffffff);
  static Color greyColor = Color(0xff79828B);
  static Color blackColor = Color(0xff42505C);
  static Color deepBlack = Color(0xff000000);






  static ThemeData lightTheme = ThemeData(
    primaryColor:primaryLight ,

    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30)  , bottomRight:Radius.circular(50))
      ),
    ),

    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 25,
        color: whitColor,
      ),

      titleMedium: TextStyle(
        fontSize: 15,
        color: primaryLight,
      ),

      titleSmall: TextStyle(
        fontSize: 15,
        color: greyColor,
      ),
     bodyLarge: TextStyle(
        fontSize: 18,
        color: blackColor,
       fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        color: deepBlack,
        fontWeight: FontWeight.bold,
      ),

    ),


  );
}