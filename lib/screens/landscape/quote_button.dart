import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/widgets.dart';

class GetQuoteButton extends StatelessWidget {
  final Function onTap;
  GetQuoteButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: RotatedBox(
        quarterTurns: 3,
        child: SizedBox(
          height: 80,
          width: 90,
          child: Point(
            triangleHeight: 20.0,
            edge: Edge.LEFT,
            child: Container(
              color: AppTheme.lightTheme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, right: 30),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Free Quote',
                    textAlign: TextAlign.center,
                    style: TextConstants.H6.apply(color: LightColor.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
