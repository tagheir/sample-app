import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/widgets.dart';

class QuickLinkCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Function onTap;
  final double width;
  final bool isQuote;
  QuickLinkCard(
      {this.width, this.title, this.imagePath, this.onTap, this.isQuote});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: isQuote == true
          ? Container(
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: LightColor.white,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppTheme.lightTheme.dividerColor,
                    offset: Offset(4, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              width: this.width,
              height: this.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(this.title,
                        textAlign: TextAlign.center,
                        style: TextConstants.H4.apply(color: LightColor.navy))
                    .center(),
              ))
          : Container(
              margin: EdgeInsets.only(left: 8),
              decoration: LayoutConstants.boxDecoration,
              width: this.width,
              height: this.width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      height: this.width * 0.8, child: Image.asset(imagePath)),
                  Text(this.title,
                      style: TextConstants.H7.apply(color: LightColor.black))
                ],
              )),
    );
  }
}
