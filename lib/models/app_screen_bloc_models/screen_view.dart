import 'package:flutter/material.dart';

// class ScreenView<T> {
//   T screenData;
// }

// abstract class ScreenViewExtended extends StatelessWidget implements {
//   @override
//   Widget build(BuildContext context);
// }

// ignore: must_be_immutable
abstract class ScreenView<T> extends StatefulWidget {
  T screenData;
}
