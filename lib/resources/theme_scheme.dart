import 'dart:ui';
import 'package:flutter/material.dart';

class ThemeScheme {
  static Map<int, Color> colorSwatch = {
    50: Color.fromRGBO(71, 53, 24, .1),
    100: Color.fromRGBO(71, 53, 24, .2),
    200: Color.fromRGBO(71, 53, 24, .3),
    300: Color.fromRGBO(71, 53, 24, .4),
    400: Color.fromRGBO(71, 53, 24, .5),
    500: Color.fromRGBO(71, 53, 24, .6),
    600: Color.fromRGBO(71, 53, 24, .7),
    700: Color.fromRGBO(71, 53, 24, .8),
    800: Color.fromRGBO(71, 53, 24, .9),
    900: Color.fromRGBO(71, 53, 24, 1),
  };

  static Map<int, Color> landSwatch = {
    50: Color.fromRGBO(0, 255, 46, .1),
    100: Color.fromRGBO(0, 255, 46, .2),
    200: Color.fromRGBO(0, 255, 46, .3),
    300: Color.fromRGBO(0, 255, 46, .4),
    400: Color.fromRGBO(0, 255, 46, .5),
    500: Color.fromRGBO(0, 255, 46, .6),
    600: Color.fromRGBO(0, 255, 46, .7),
    700: Color.fromRGBO(0, 255, 46, .8),
    800: Color.fromRGBO(0, 255, 46, .9),
    900: Color.fromRGBO(0, 255, 46, 1),
  };

  static Map<int, Color> storeSwatch = {
    50: Color.fromRGBO(6, 45, 102, 0.1),
    100: Color.fromRGBO(6, 45, 102, .2),
    200: Color.fromRGBO(6, 45, 102, .3),
    300: Color.fromRGBO(6, 45, 102, .4),
    400: Color.fromRGBO(6, 45, 102, .5),
    500: Color.fromRGBO(6, 45, 102, .6),
    600: Color.fromRGBO(6, 45, 102, .7),
    700: Color.fromRGBO(6, 45, 102, .8),
    800: Color.fromRGBO(6, 45, 102, .9),
    900: Color.fromRGBO(6, 45, 102, 1),
  };
  //****Fields****//
//  static final appbarColor = const Color(0xFFEA7623);
  static final iconColorDrawer = const Color(0xFFEA7623);
  static final iconColorNavBar = const Color(0xFFFFFFFF);
  static MaterialColor swatchColor = MaterialColor(0xffEA7623, colorSwatch);
  static MaterialColor landSwatchColor = MaterialColor(0xff2E7D32, landSwatch);
  static MaterialColor storeSwatchColor =
      MaterialColor(0xff062D66, storeSwatch);
  //static final iconColorNavBar=const
//  static final Text_style = FontStyle.italic;
//  static final double fontsize = 40.0;

  //*****Dark Theme****
//  static final ThemeData darkTheme = ThemeData.dark().copyWith(
//      primaryColor: Color(0xFFEA7623),
//      accentColor: Color(0xff40bf7a),
//      textTheme: TextTheme(
//          title: TextStyle(color: Color(0xff40bf7a)),
//          subtitle: TextStyle(color: Colors.white),
//          subhead: TextStyle(color: Color(0xff40bf7a))),
//      appBarTheme: AppBarTheme(color: Color(0xff1f655d)));

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xFFEA7623),
    backgroundColor: Color(0xFFFFFFFF),
    textSelectionColor: Color(0xFFEA7623),
    cursorColor: Color(0xFFEA7623),
    accentColor: Color(0xff40bf7a),
    // iconTheme: IconThemeData(color:0xFFEA7623),
    appBarTheme: AppBarTheme(
        color: Color(0xFFEA7623),
        actionsIconTheme: IconThemeData(color: Colors.black)),
    // textTheme: TextTheme(
    //   title: TextStyle(color: Colors.black54),
    //   subtitle: TextStyle(color: Colors.red),
    //   subhead: TextStyle(color: Colors.green),
    //   body2: TextStyle(color: Colors.black),
    //   //body1: TextStyle(color: Colors.green),
    //   // body1: TextStyle(color: Colors.green),
    // ),
  );
}

class StyleThemeConstants {
  static const double cardBorderRadiusSize = 20.0;
}
