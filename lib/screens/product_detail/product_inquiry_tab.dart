import 'package:bluebellapp/resources/constants/app_routes.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/bottom_sheet_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductInquiryTab extends StatelessWidget {
  final Function() onCallClick;
  final Function() onFormClick;
  final Function() onButtonClick;
  final Color buttonColor;
  final double height;
  ProductInquiryTab(
      {this.onCallClick,
      this.onFormClick,
      this.buttonColor,
      this.height,
      this.onButtonClick});
  @override
  Widget build(BuildContext context) {
    double pad = 15;
    if (this.height != null) {
      pad = ((this.height - 50) / 2);
    }
    ////print(height);
    return Container(
      height: height,
      decoration: LayoutConstants.boxDecorationWithTopRadius,
      child: Padding(
        padding: EdgeInsets.only(top: pad, left: 15, right: 15, bottom: pad),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BottomSheetIconButton(
              onPressed: () {
                //onCallClick();
                _launchURL(AppRoutes.PhoneNumberLink);
                onButtonClick();
              },
              flex: 2,
              icon: Icons.call,
              backgroundColor: buttonColor ?? AppTheme.lightTheme.primaryColor,
            ),
            _divider(),
            BottomSheetIconButton(
              flex: 2,
              onPressed: () {
                _launchURL(AppRoutes.WhatsAppLink);
                onButtonClick();
              },
              faIcon: FontAwesomeIcons.whatsapp,
              color: Colors.white,
              backgroundColor: buttonColor ?? AppTheme.lightTheme.primaryColor,
            ),
            _divider(),
            BottomSheetIconButton(
              flex: 2,
              onPressed: onFormClick,
              icon: Icons.question_answer,
              backgroundColor: buttonColor ?? AppTheme.lightTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Container _divider() {
    return Container(
      height: 50.0,
      width: 1.0,
      color: Colors.grey,
      padding: EdgeInsets.all(0),
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ////print('Could not launch $url');
    }
  }
}
