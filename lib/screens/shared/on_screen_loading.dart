import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnScreenLoading extends StatelessWidget {
  const OnScreenLoading({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      child: Container(
        height: size.height,
        width: size.width,
        color: LightColor.black.withOpacity(0.5),
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(
              backgroundColor: AppTheme.lightTheme.primaryColor,
            ),
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }
}
