import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ServiceImageCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double width;
  bool heightHalfOfWidth = false;
  ServiceImageCard(
      {this.width, this.title, this.imagePath, this.heightHalfOfWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        decoration: LayoutConstants.boxDecoration,
        width: this.width,
        height: this.heightHalfOfWidth == false ? this.width : this.width / 2,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ClipRRect(
              borderRadius: LayoutConstants.borderRadius,
              child: Image.asset(
                this.imagePath,
                width: 500,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                this.title,
                style: TextConstants.H7.apply(color: LightColor.white).apply(
                  shadows: [
                    Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black),
                  ],
                ),
              ).padding(EdgeInsets.all(10)),
            ),
          ],
        ));
  }
}
