import 'package:bluebellapp/bloc/app_screen_bloc/app_screen_event.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '_safe_area_screen.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  ErrorScreen({this.error});
  @override
  Widget build(BuildContext context) {
    return SafeAreaScreen(
      padding: MediaQuery.of(context).padding.top * 0.3,
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.getAppScreenBloc().add(AppScreenLoadingEvent());
              },
              child: Icon(Icons.refresh, color: LightColor.grey, size: 40
                      //color: Colors.white,
                      )
                  .center(),
            ),
            LayoutConstants.sizedBox20H,
            Text(
              error,
              style: TextConstants.H6.apply(color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
