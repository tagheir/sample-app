import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';

class Common {
  static Widget buildTile(Widget child, {Function() onTap}) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
          elevation: 16.0,
          borderRadius: LayoutConstants.borderRadius,
          //shadowColor: Color(0x802196F3),
          child: InkWell(
              // Do onTap() if it isn't null, otherwise do ////print()
              onTap: onTap != null
                  ? () => onTap()
                  : () {
                      ////print('Not set yet');
                    },
              child: child)),
    );
  }

  static InputBorder getCircularInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(48.0)),
      borderSide: BorderSide(width: 0, style: BorderStyle.none),
    );
  }

  static InputDecoration getInputDecoration(
      {bool circularBorder = false,
      Color backgroundColor,
      Color color,
      IconData icon,
      IconData suffixIcon,
      String hintText,
      String labelText,
      String helperText}) {
    return InputDecoration(
        border: circularBorder
            ? Common.getCircularInputBorder()
            : const UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor),
        ),
        hintStyle: TextStyle(color: Colors.black87),
        labelStyle: TextStyle(color: Colors.black87),
        // filled: true,
        fillColor: backgroundColor,
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: AppTheme.lightTheme.primaryColor,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: AppTheme.lightTheme.primaryColor,
              )
            : null,
        //prefixStyle: TextStyle(backgroundColor: color),
        hintText: hintText,
        labelText: labelText,
        helperText: helperText);
  }
}
