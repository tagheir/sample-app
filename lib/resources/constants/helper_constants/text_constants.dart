import 'package:bluebellapp/resources/constants/colors.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextConstants {
  // Headings
  static double fontVariant = 1;
  static TextStyle H1 = GoogleFonts.montserrat(
      fontSize: 40 * fontVariant, fontWeight: FontWeight.bold);
  static TextStyle H2 = GoogleFonts.montserrat(
      fontSize: 32 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);
  static TextStyle H3 = GoogleFonts.montserrat(
      fontSize: 28 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);
  static TextStyle H4 = GoogleFonts.montserrat(
      fontSize: 24 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);
  static TextStyle H5 = GoogleFonts.montserrat(
      fontSize: 20 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);
  static TextStyle H6_5 = GoogleFonts.montserrat(
      fontSize: 18 / fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);
  static TextStyle H6 = GoogleFonts.montserrat(
      fontSize: 16 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);
  static TextStyle H7 = GoogleFonts.montserrat(
      fontSize: 14 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);

  static TextStyle H8 = GoogleFonts.montserrat(
      fontSize: 12 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);

  static TextStyle H9 = GoogleFonts.montserrat(
      fontSize: 10 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      fontWeight: FontWeight.bold);

  static TextStyle P1 = GoogleFonts.montserrat(
      fontSize: 40 * fontVariant,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      fontWeight: FontWeight.normal);
  static TextStyle P2 = GoogleFonts.montserrat(
      fontSize: 32 * fontVariant,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      fontWeight: FontWeight.normal);
  static TextStyle P3 = GoogleFonts.montserrat(
      fontSize: 28 * fontVariant,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      fontWeight: FontWeight.normal);
  static TextStyle P4 = GoogleFonts.montserrat(
      fontSize: 24 * fontVariant,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.normal);
  static TextStyle P5 = GoogleFonts.montserrat(
      fontSize: 20 * fontVariant,
      decoration: TextDecoration.none,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      fontWeight: FontWeight.normal);
  static TextStyle P6_5 = GoogleFonts.montserrat(
      fontSize: 18 * fontVariant,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      fontWeight: FontWeight.normal);
  static TextStyle P6 = GoogleFonts.montserrat(
      fontSize: 16 * fontVariant,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      fontWeight: FontWeight.normal);
  static TextStyle P7 = GoogleFonts.montserrat(
      fontSize: 14 * fontVariant,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      fontWeight: FontWeight.normal);
  static TextStyle P8 = GoogleFonts.montserrat(
      fontSize: 12 * fontVariant,
      //fontFamily: GeneralStrings.FONT_SECONDARY,
      fontWeight: FontWeight.normal);

  static TextStyle CPH8 = GoogleFonts.montserrat(
      fontSize: 12 * fontVariant,
      //fontFamily: GeneralStrings.FONT_PRIMARY,
      color: LightColor.orange,
      fontWeight: FontWeight.bold);
}

extension TextStyleExtensions on TextStyle {
  TextStyle primary() => this.apply(color: BBColors.primaryColor);
  TextStyle white() => this.apply(color: Colors.white);
}
