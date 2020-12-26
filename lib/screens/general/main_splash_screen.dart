import 'package:bluebellapp/resources/constants/colors.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class MainSplashScreen extends StatelessWidget {
  final bool showLoading;

  const MainSplashScreen({Key key, this.showLoading = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppTheme.deviceWidth = AppTheme.fullWidth(context);
    AppTheme.deviceHeight = AppTheme.fullHeight(context);
    var list = List<Widget>();
    list.add(
      Padding(
        padding: const EdgeInsets.only(left: 80, right: 80, bottom: 20),
        child: Image.asset(
          'assets/images/logo.png',
          width: double.infinity,
        ),
      ),
    );
    if (this.showLoading == true) {
      list.add(LoadingIndicator());
    }
    return Scaffold(
      backgroundColor: BBColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list,
        ),
      ),
    );
  }
}
