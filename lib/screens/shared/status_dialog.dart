import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';

class StatusDialog {
  final BuildContext cntxt;
  final String message;
  final bool status;
  StatusDialog({this.cntxt, this.message, this.status});
  show() {
    return showDialog(
      context: cntxt,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              status == true ? message : "Something went wrong. Try again."),
          actions: [
            FlatButton(
              child: Text("OK",
                  style: TextConstants.H5
                      .apply(color: AppTheme.lightTheme.primaryColor)),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
