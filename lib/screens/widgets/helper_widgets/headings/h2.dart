import 'package:flutter/material.dart';

class H2 extends StatelessWidget {
  final String text;
  const H2(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              )),
        ),
      ],
    );
  }
}
