import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';

// ignore: must_be_immutable
class BottomSheetIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final IconData faIcon;
  final Widget body;
  final Color color;
  final Color backgroundColor;
  final int flex;
  final double height;
  final double width;
  double size = 24;
  BottomSheetIconButton({
    Key key,
    @required this.onPressed,
    this.icon,
    this.color = Colors.white,
    this.backgroundColor = LightColor.orange,
    this.flex = 1,
    this.faIcon,
    this.height = 50,
    this.width = 50,
    this.size,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isIcon() ? width : double.infinity,
      height: height,
      margin: EdgeInsets.only(top: 4),
      child: RaisedButton(
        onPressed: onPressed,
        color: backgroundColor,
        padding: EdgeInsets.zero,
        child: getBody(),
        shape: RoundedRectangleBorder(
          borderRadius: LayoutConstants.borderRadius,
        ),
      ),
    );
  }

  bool isIcon() => icon != null || faIcon != null;

  StatelessWidget getBody() {
    if (icon != null) return Icon(icon, size: size, color: color);
    if (faIcon != null) return FaIcon(faIcon, size: size, color: color);
    if (body != null) return body;
    return Text('');
  }
}
