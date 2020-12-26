import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';

class FixedBottomButton extends StatelessWidget {
  const FixedBottomButton(
      {Key key, @required this.onTap, this.text, this.child, this.tabColor})
      : super(key: key);

  final Function() onTap;
  final String text;
  final Widget child;
  final Color tabColor;

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final height = 60.0;
    //var height = 70.0;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: this.tabColor == null
              ? AppTheme.lightTheme.primaryColor
              : this.tabColor,
          borderRadius:
              BorderRadius.vertical(top: LayoutConstants.borderRadius8),
        ),
        height: height,
        width: appSize.width,
        child: Center(
          child: child ??
              Text(
                text,
                style: TextConstants.H6_5.apply(
                  color: Colors.white,
                ),
              ),
        ),
      ),
    );
  }
}
