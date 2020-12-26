import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/text_widgets/general-text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainCategoryCard extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String title;
  final Icon icon;
  final String imagePath;
  final Color textColor;
  final Function onClick;
  bool addOpacity;
  MainCategoryCard({
    this.backgroundColor,
    this.borderColor,
    this.title,
    this.icon,
    this.imagePath,
    this.onClick,
    this.addOpacity,
    this.textColor = LightColor.lightBlack,
  });
  @override
  Widget build(BuildContext context) {
    ////print(imagePath);
    addOpacity = addOpacity ?? false;
    var outerWidth = (AppTheme.deviceWidth - 40) / 3;
    //print(AppTheme.deviceHeight);
    //print(outerWidth);
    var padding = 20.0;
    var width = outerWidth - padding;
    //print(width);
    return GestureDetector(
      onTap: () {
        if (onClick != null) {
          onClick();
        }
      },
      child: Container(
        width: outerWidth,
        height: outerWidth * 1.1,
        color: addOpacity == true
            ? Colors.transparent.withOpacity(0.0)
            : this.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              height: width * 0.9098,
              margin: EdgeInsets.only(bottom: 2),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                  color: borderColor,
                ),
              ),
              child: icon != null
                  ? icon
                  : Image.asset(
                      this.imagePath,
                      height: width * 0.9098,
                      width: width,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              height: 30,
              child: Center(
                child: GeneralText(
                  this.title,
                  color: textColor,
                  fontSize: outerWidth * 0.076,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
