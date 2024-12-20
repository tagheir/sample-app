import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
          child: CircularProgressIndicator(
        backgroundColor: AppTheme.lightTheme.primaryColor,
      ));
}
