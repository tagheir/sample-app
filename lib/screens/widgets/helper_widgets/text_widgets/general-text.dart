import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;
  GeneralText(
    this.text, {
    this.fontWeight = FontWeight.w400,
    this.fontSize = 12,
    this.textAlign = TextAlign.left,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      textAlign: this.textAlign,
      style: TextStyle(
          fontWeight: this.fontWeight,
          fontSize: this.fontSize,
          color: this.color),
    );
  }
}
