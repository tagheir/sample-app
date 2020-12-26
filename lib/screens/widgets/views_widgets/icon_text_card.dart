import 'package:bluebellapp/screens/widgets/helper_widgets/common.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:flutter/material.dart';

class IconTextCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String subText;
  final Color cardColor;
  final Color textColor;
  final Function() onTap;
  IconTextCard({
    @required this.text,
    this.subText = '',
    @required this.icon,
    this.cardColor = Colors.white,
    this.textColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    var card = Container(
      decoration: BoxDecoration(
        borderRadius: LayoutConstants.borderRadius,
        color: cardColor,
      ),
      padding: const EdgeInsets.all(24.0),
      width: 170,
      height: 170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
              color: textColor.withOpacity(0.5),
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  icon,
                  color: cardColor,
                  size: 22.0,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
          ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10),
          Text(
            subText,
            style: TextStyle(
              color: textColor.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
    return Common.buildTile(card, onTap: this.onTap);
  }
}
