import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingSliderDots extends StatelessWidget {
  bool isActive;
  OnboardingSliderDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: isActive ? 10 : 6,
      width: isActive ? 10 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        border: isActive ?  Border.all(color: Color(0xff927DFF),width: 2.0,) : Border.all(color: Colors.transparent,width: 1,),
        borderRadius: LayoutConstants.borderRadius,
      ),
    );
  }
}
