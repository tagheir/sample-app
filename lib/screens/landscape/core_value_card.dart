import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:flutter/widgets.dart';

class CoreValueCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final double width;
  CoreValueCard({this.width, this.title, this.imagePath, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        decoration: LayoutConstants.boxDecoration,
        width: this.width,
        height: this.width / 2,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ClipRRect(
              borderRadius: LayoutConstants.borderRadius,
              child: Image.asset(
                this.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
                  child: Text(this.title,
                      style: TextConstants.H7.apply(color: LightColor.white)),
                ),
              ),
            ),
          ],
        ));
  }
}
