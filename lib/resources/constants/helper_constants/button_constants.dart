import 'package:bluebellapp/resources/constants/colors.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:flutter/material.dart';

class ButtonConstants {
  // Button Styles
  static Text defaultButton(String text,
          {TextAlign textAlign = TextAlign.center}) =>
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
        ),
        textAlign: textAlign,
      );

  static MaterialButton button(String text, void Function() onPressed) =>
      FlatButton(
        child: Text(text),
        onPressed: onPressed,
      );

  static Widget blockButton({
    @required Widget child,
    void Function() onPressed,
    EdgeInsetsGeometry padding = LayoutConstants.edgeInsets6H12V,
    Color textColor,
    Color backgroundColor,
    ShapeBorder shape,
  }) {
    shape = shape ?? LayoutConstants.shapeBorderRadius10;
    return Padding(
      padding: padding,
      child: MaterialButton(
        child: child,
        onPressed: onPressed,
        minWidth: 400,
        height: 50,
        textColor: textColor,
        color: backgroundColor,
        shape: shape,
      ),
    );
  }

  static Widget primaryBlockButton({
    @required Widget child,
    void Function() onPressed,
    EdgeInsetsGeometry padding = LayoutConstants.edgeInsets6H12V,
    ShapeBorder shape,
  }) =>
      blockButton(
        child: child,
        onPressed: onPressed,
        padding: padding,
        backgroundColor: BBColors.primaryColor,
        textColor: BBColors.textColorOverPrimaryBase,
        shape: shape,
      );
}

extension ButtonExtensions on MaterialButton {}
