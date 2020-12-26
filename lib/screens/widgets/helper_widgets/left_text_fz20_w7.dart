import 'package:flutter/material.dart';

class LeftTextFz20Fw7 extends StatelessWidget {
  final String title;

  const LeftTextFz20Fw7(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      //textDirection: TextDirection.rtl,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
  }
}
