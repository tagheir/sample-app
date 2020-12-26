import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';

import 'move_back_button.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  final Widget leading, trailing, child;
  final String title;
  final double height, width;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final AppState returnState;
  bool isBig = false;

  CustomAppBar(
      {Key key,
      this.leading,
      this.trailing,
      this.title,
      this.height,
      this.width,
      this.isBig,
      this.child,
      this.returnState,
      this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title ?? '',
              style: TextConstants.H5.apply(color: LightColor.white))
          .padding(EdgeInsets.only(top: 25)),
      centerTitle: true,
      backgroundColor: AppTheme.lightTheme.primaryColor,
      // shape: CustomShapeBorder(height: this.height, width: this.width),
      leading: MoveBackButton(
        scaffoldKey: this.scaffoldKey,
        color: LightColor.white,
      ).padding(EdgeInsets.only(top: 25)),
    );
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  final double height;
  final double width;
  CustomShapeBorder({@required this.height, @required this.width});
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    path.moveTo(0, this.height - 30);
    path.cubicTo(this.width / 2, 3 * this.height / 2, 3 * this.width / 2,
        this.height / 3, this.width, this.height / 2);
    // path.quadraticBezierTo(
    //     this.width / 2, this.height, this.width, this.height - 40);
    path.lineTo(this.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }
}
