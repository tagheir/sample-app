import 'package:bluebellapp/screens/widgets/helper_widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final bool showLoading;

  const SplashScreen({Key key, this.showLoading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[LoadingIndicator()],
        ),
      ),
    );
  }
}
