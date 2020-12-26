import 'package:bluebellapp/resources/constants/colors.dart';
import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'light_color.dart';

class AppTheme {
  const AppTheme();
  static ThemeData getThemeData(BuildContext context) {
    //setStatusBar();
    return getTheme(context);
  }

  static setStatusBar({bool light = false}) async {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Color(0xff141321).withOpacity(0.5),
    //     statusBarIconBrightness: Brightness.light));
    FlutterStatusbarcolor.setStatusBarColor(Color(0xff7b7b7b).withOpacity(0.4));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      canvasColor: Colors.white,
      backgroundColor: LightColor.background,
      primaryColor: LightColor.orange,
      primarySwatch: ThemeScheme.swatchColor,
      cardTheme: CardTheme(color: LightColor.background),
      cursorColor: LightColor.orange,
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
      iconTheme: IconThemeData(color: LightColor.iconColor),
      bottomAppBarColor: LightColor.background,
      dividerColor: LightColor.lightGrey,
      primaryTextTheme: TextTheme(
        body1: TextStyle(color: LightColor.titleTextColor),
      ),
    );
  }

  static ThemeData lightTheme;

  static setStoreTheme() {
    lightTheme = ThemeData(
        backgroundColor: LightColor.background,
        primaryColor: LightColor.navy,
        primarySwatch: ThemeScheme.storeSwatchColor,
        cardTheme: CardTheme(color: LightColor.background),
        cursorColor: LightColor.orange,
        textTheme: TextTheme(display1: TextStyle(color: LightColor.black)),
        iconTheme: IconThemeData(color: LightColor.iconColor),
        bottomAppBarColor: LightColor.background,
        dividerColor: LightColor.lightGrey,
        primaryTextTheme:
            TextTheme(body1: TextStyle(color: LightColor.titleTextColor)));
    // setStatusBar();
  }

  static setServicesTheme() {
    lightTheme = ThemeData(
        backgroundColor: LightColor.background,
        primaryColor: LightColor.orange,
        primarySwatch: ThemeScheme.swatchColor,
        cardTheme: CardTheme(color: LightColor.background),
        cursorColor: LightColor.orange,
        textTheme: TextTheme(display1: TextStyle(color: LightColor.black)),
        iconTheme: IconThemeData(color: LightColor.iconColor),
        bottomAppBarColor: LightColor.background,
        dividerColor: LightColor.lightGrey,
        primaryTextTheme:
            TextTheme(body1: TextStyle(color: LightColor.titleTextColor)));
    // setStatusBar();
  }

  static setLandscapeTheme() {
    lightTheme = ThemeData(
        backgroundColor: LightColor.background,
        primaryColor: LightColor.landGreen,
        primarySwatch: ThemeScheme.landSwatchColor,
        cardTheme: CardTheme(color: LightColor.background),
        cursorColor: LightColor.landGreen,
        textTheme: TextTheme(display1: TextStyle(color: LightColor.black)),
        iconTheme: IconThemeData(color: LightColor.iconColor),
        bottomAppBarColor: LightColor.background,
        dividerColor: LightColor.lightGrey,
        primaryTextTheme:
            TextTheme(body1: TextStyle(color: LightColor.titleTextColor)));
    // setStatusBar();
  }

  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets h_5Padding = const EdgeInsets.symmetric(horizontal: 5);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(horizontal: 10);
  static EdgeInsets h2Padding = const EdgeInsets.symmetric(horizontal: 20);
  static EdgeInsets vPadding = const EdgeInsets.symmetric(vertical: 10);

  static double deductedHeight = 0.0;
  static double deductedWidth = 0.0;
  static double deviceWidth = 0.0;
  static double deviceHeight = 0.0;

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * (1 - deductedWidth);
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * (1 - deductedHeight);
  }

  static Size size(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
