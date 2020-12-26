import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingSliderItem {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  OnBoardingSliderItem(
      {@required this.sliderImageUrl,
      @required this.sliderHeading,
      @required this.sliderSubHeading});
}

final sliderArrayList = [
    OnBoardingSliderItem(
        sliderImageUrl: 'assets/images/onboarding_slider_1.png',
        sliderHeading: GeneralStrings.SLIDER_HEADING_1,
        sliderSubHeading: GeneralStrings.SLIDER_DESC),
    OnBoardingSliderItem(
        sliderImageUrl: 'assets/images/onboarding_slider_2.png',
        sliderHeading: GeneralStrings.SLIDER_HEADING_2,
        sliderSubHeading: GeneralStrings.SLIDER_DESC),
    OnBoardingSliderItem(
        sliderImageUrl: 'assets/images/onboarding_slider_3.png',
        sliderHeading: GeneralStrings.SLIDER_HEADING_3,
        sliderSubHeading: GeneralStrings.SLIDER_DESC),
  ];
