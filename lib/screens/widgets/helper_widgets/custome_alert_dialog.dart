import 'package:flutter/material.dart';

class CustomAlertDialog {
  final String text;
  final BuildContext context;

  CustomAlertDialog({Key key, this.text, this.context}) {
    //////print(this.text);
    //////print(this.cntxt);
  }
  show() {}
  static showNew({
    String text,
    BuildContext cntxt,
    int seconds = 4,
  }) {
    showDialog(
        context: cntxt,
        builder: (context) {
          Future.delayed(Duration(seconds: seconds), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text(text),
          );
        });
  }
}
