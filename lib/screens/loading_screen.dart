import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/move_back_button.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/loading_indicator.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ////print("LOADING SCREEN !!!!");
    var widgets = List<Widget>();
    if (!context.getAppBloc().isFirstTimeLoad) {
      widgets.add(MoveBackButton(
        scaffoldKey: scaffoldKey,
        icon: Icons.close,
      ));
    }
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.lightTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: widgets,
          // leading: context.getAppBloc().isFirstTimeLoad
          //     ? null
          //     : MoveBackButton(
          //         scaffoldKey: scaffoldKey,
          //       ),
        ),
        body: Center(
          child: LoadingIndicator(),
        ));
  }
}
