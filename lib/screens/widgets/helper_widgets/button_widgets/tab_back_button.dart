import 'package:flutter/material.dart';

class TabBackButton extends StatelessWidget {
  final Function callback;
  TabBackButton({this.callback});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          callback();
        });
  }
}
