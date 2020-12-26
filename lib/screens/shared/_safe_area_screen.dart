import 'package:flutter/widgets.dart';

class SafeAreaScreen extends StatelessWidget {
  final Widget child;
  final double padding;
  SafeAreaScreen({this.child, this.padding});
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      removeLeft: true,
      removeRight: true,
      child: child,
    );
  }
}
