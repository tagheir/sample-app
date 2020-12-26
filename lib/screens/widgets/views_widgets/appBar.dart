import 'package:bluebellapp/screens/widgets/helper_widgets/button_widgets/tab_back_button.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/text_widgets/general-text.dart';
import 'package:flutter/material.dart';

abstract class CustomAppBar implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  final Function callBack;
  CustomAppBar(this.callBack, this.title, this.context);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget build(BuildContext context) {
    return AppBar(
      title: GeneralText(
        title == null ? '' : title.toString(),
        fontSize: 20,
      ),
      leading: TabBackButton(
        callback: () {
          callBack();
        },
      ),
    );
  }
}
