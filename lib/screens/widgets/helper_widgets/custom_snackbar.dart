import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String text;
  final BuildContext context;
  CustomSnackBar({this.text, this.context});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text(text),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(this.context).showSnackBar(snackBar);
        },
        //child: Text('Show SnackBar'),
      ),
    );
  }
}
