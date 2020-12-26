import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:bluebellapp/resources/themes/theme.dart';

class DataEmpty extends StatelessWidget {
  final String message;
   DataEmpty({this.message});
  @override
  Widget build(BuildContext context) => Container(
    height: AppTheme.fullHeight(context) * 0.5,
    child: Center(
          child: Text(message,  style: TextConstants.H7),
        ),
  );
}
