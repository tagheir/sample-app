import 'dart:async';

import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/onboarding_slider.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/screens/onboarding/onboarding_slider_dots.dart';
import 'package:bluebellapp/screens/onboarding/onboarding_slider_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingSliderLayoutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnBoardingSliderLayoutViewState();
}

class _OnBoardingSliderLayoutViewState
    extends State<OnBoardingSliderLayoutView> {
  int _currentPage = 0;
  OnBoardingSliderItem _currentPageItem = sliderArrayList[0];
  final PageController _pageController = PageController(initialPage: 0);
  Timer _localTimer;
  @override
  void initState() {
    super.initState();
    _localTimer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < sliderArrayList.length) {
        setState(() {
          _currentPage++;
          _currentPageItem = sliderArrayList[_currentPage];
        });
      }

      ////print(_currentPage);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    ////print(index);
    setState(() {
      _currentPage = index;
      _currentPageItem = sliderArrayList[_currentPage];
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: sliderArrayList.length,
                  itemBuilder: (ctx, i) =>
                      OnBoardingSliderItemWidget(_currentPageItem),
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: _currentPage >= sliderArrayList.length - 1
                          ? MaterialButton(
                              onPressed: () {
                                _localTimer.cancel();
                                context.getAppBloc().add(LoginScreenEvent());
                              },
                              child: Text(GeneralStrings.GET_STARTED),
                            )
                          : FlatButton(
                              onPressed: () {
                                _onPageChanged(_currentPage + 1);
                              },
                              child: Text(
                                GeneralStrings.NEXT,
                                style: TextStyle(
                                  fontFamily: GeneralStrings.FONT_SECONDARY,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: FlatButton(
                        onPressed: () {
                          _localTimer.cancel();
                          context.getAppBloc().add(LoginScreenEvent());
                        },
                        child: Text(
                          GeneralStrings.SKIP,
                          style: TextStyle(
                            fontFamily: GeneralStrings.FONT_SECONDARY,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < sliderArrayList.length; i++)
                            if (i == _currentPage)
                              OnboardingSliderDots(true)
                            else
                              OnboardingSliderDots(false)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
}
