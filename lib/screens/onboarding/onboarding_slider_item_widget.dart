import 'package:bluebellapp/models/onboarding_slider.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingSliderItemWidget extends StatelessWidget {
  final OnBoardingSliderItem item;
  OnBoardingSliderItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.6,
          width: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(item.sliderImageUrl))),
        ),
        SizedBox(
          height: 60.0,
        ),
        Text(
          item.sliderHeading,
          style: TextStyle(
            fontFamily: GeneralStrings.FONT_PRIMARY,
            fontWeight: FontWeight.w700,
            fontSize: 20.5,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              item.sliderSubHeading,
              style: TextStyle(
                fontFamily: GeneralStrings.FONT_PRIMARY,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                fontSize: 12.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
