import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/landscape/core_value_card.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LandscapeAboutScreen extends StatefulWidget {
  @override
  _LandscapeAboutScreenState createState() => _LandscapeAboutScreenState();
}

class _LandscapeAboutScreenState extends State<LandscapeAboutScreen> {
  Widget body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  getWelcomeImage() {
    return Container(
      decoration: LayoutConstants.boxDecoration,
      // height: MediaQuery.of(context).size.height / 4,
      // width: MediaQuery.of(context).size.width - 16,
      child: ClipRRect(
        borderRadius: LayoutConstants.borderRadius,
        child: Image.asset(
          "assets/images/landscape_service.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  getWelcomeNote() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(GeneralStrings.WELCOME_TO_BLUEBELL,
        //     style: TextConstants.H5.apply(color: LightColor.landGreen)),
        // LayoutConstants.sizedBox5H,
        Text(GeneralStrings.COMPLETE_SOLUTION,
            style: TextConstants.H4.apply(color: LightColor.landGreen)),
        LayoutConstants.sizedBox5H,
        Text(GeneralStrings.FOR_LANDSCAPING_VISION,
            style: TextConstants.H6.apply(color: LightColor.black)),
        LayoutConstants.sizedBox10H,
        Text(GeneralStrings.LANDSCAPE_WELCOME_TEXT,
            style: TextConstants.P6.apply(color: LightColor.black)),
        LayoutConstants.sizedBox10H,
        getWelcomeImage(),
        LayoutConstants.sizedBox20H,
      ],
    ).padding(EdgeInsets.symmetric(horizontal: 8));
  }

  getPromotionalText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(GeneralStrings.OUR_MISSION,
            style: TextConstants.H5.apply(color: LightColor.landGreen)),
        LayoutConstants.sizedBox10H,
        Text(GeneralStrings.OUR_MISSION_TEXT,
            style: TextConstants.P6.apply(color: LightColor.black)),
        LayoutConstants.sizedBox20H,
        Text(GeneralStrings.OUR_VISION,
            style: TextConstants.H5.apply(color: LightColor.landGreen)),
        LayoutConstants.sizedBox10H,
        Text(GeneralStrings.OUR_VISION_TEXT,
            style: TextConstants.P6.apply(color: LightColor.black)),
        LayoutConstants.sizedBox20H,
      ],
    ).padding(EdgeInsets.symmetric(horizontal: 8));
  }

  getCoreValues() {
    var coreValuesCards = List<Widget>();
    var availableWidth = MediaQuery.of(context).size.width / 2 - 16;
    coreValuesCards.add(CoreValueCard(
      width: availableWidth,
      title: GeneralStrings.WE_ARE_FAMILY,
      imagePath: 'assets/images/landscape/6.jpg',
    ));
    coreValuesCards.add(CoreValueCard(
      width: availableWidth,
      title: GeneralStrings.PURSUE_LIFE_BALANCE,
      imagePath: 'assets/images/landscape/4.jpg',
    ));
    coreValuesCards.add(CoreValueCard(
      width: availableWidth,
      title: GeneralStrings.DO_WHAT_YOU_SAY,
      imagePath: 'assets/images/landscape/1.jpg',
    ));
    coreValuesCards.add(CoreValueCard(
      width: availableWidth,
      title: GeneralStrings.RESPECT_ALL_THINGS,
      imagePath: 'assets/images/landscape/4.png',
    ));
    coreValuesCards.add(CoreValueCard(
      width: availableWidth,
      title: GeneralStrings.FIND_A_WAY,
      imagePath: 'assets/images/landscape/5.png',
    ));
    coreValuesCards.add(CoreValueCard(
      width: availableWidth,
      title: GeneralStrings.CREATE_RAVING_FANS,
      imagePath: 'assets/images/landscape/6.png',
    ));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(GeneralStrings.OUR_CORE_VALUES,
                style: TextConstants.H5.apply(color: LightColor.landGreen))
            .padding(EdgeInsets.symmetric(horizontal: 8)),
        LayoutConstants.sizedBox10H,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: getGridRowsList(2, coreValuesCards, availableWidth),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    body = ListView(
      padding: EdgeInsets.only(left: 8, right: 8, top: 24),
      children: [getWelcomeNote(), getPromotionalText(), getCoreValues()],
    );
    return LayoutScreen(
      childView: body,
      scaffoldKey: scaffoldKey,
      showAppbar: true,
      screenTitle: 'About Us',
      showNavigationBar: false,
      showQuoteButton: true,
      showHeaderCartButton: true,
      showFloatingButton: false,
    );
  }
}
