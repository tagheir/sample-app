import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'loading_indicator.dart';

class CustomProgressDialog {
  final BuildContext context;
  ProgressDialog pr;
  final String text;
  bool isActive = false;
  CustomProgressDialog({
    this.text,
    this.context,
  });
  showDialog({
    String message,
    BuildContext currentContext,
  }) async {
    var infoMessage = "Please wait...";
    if (text != null && text.isNotEmpty) {
      infoMessage = text;
    }
    if (message != null && message.isNotEmpty) {
      infoMessage = message;
    }
    currentContext = currentContext ?? context;

    pr = ProgressDialog(currentContext,
        type: ProgressDialogType.Normal, isDismissible: false);
    isActive = true;

    pr.style(message: infoMessage, progressWidget: LoadingIndicator());
    await pr.show();
  }

  hideDialogAsync() async {
    if (isActive == true) {
      ////print("Status => " + pr.isShowing().toString());
      var data = await pr.hide();
      if (data == true) {
        ////print("hide called");
      } else {
        ////print("hide called failed");
        //return await hideDialogAsync();
      }

      isActive = false;
    }
  }

  hideDialog() async {
    if (isActive == true) {
      ////print("Status => " + pr.isShowing().toString());
      var data = await pr.hide();
      if (data == true) {
        ////print("hide called");
      } else {
        ////print("hide called failed");
        //return await hideDialogAsync();
      }

      isActive = false;
    }
    // if (isActive == true) {
    //   pr.hide().then((data) {
    //     if (data == true) {
    //       ////print("hide called");
    //     } else {
    //       ////print("hide called failed");
    //     }
    //   });
    //   isActive = false;
    // }
  }
}
