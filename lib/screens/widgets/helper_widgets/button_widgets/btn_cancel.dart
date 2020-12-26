import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final BuildContext context;
  CancelButton({this.context});

  @override
  Widget build(BuildContext context) {
    var size = AppTheme.size(context);
    return Padding(
      padding: EdgeInsets.only(
          right: 16.0, top: context.paddingTop() + size.height * 0.05),
      child: IconButton(
        icon: Icon(
          Icons.close,
          color: AppTheme.lightTheme.primaryColor,
          size: 32,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
