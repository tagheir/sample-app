import 'dart:io';

import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:icon_shadow/icon_shadow.dart';

// ignore: must_be_immutable
class MoveBackButton extends StatelessWidget {
  MoveBackButton({
    Key key,
    this.color,
    this.icon,
    @required this.scaffoldKey,
    this.returnState,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final AppState returnState;
  final Color color;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      icon = Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back;
    }
    return IconButton(
      onPressed: () {
        scaffoldKey.currentContext.moveBack(returnState: this.returnState);
      },
      icon: IconShadowWidget(
        Icon(
          icon,
          color: color ?? AppTheme.lightTheme.primaryColor,
        ),
        shadowColor: LightColor.lightBlack,
      ),
    );
  }
}
