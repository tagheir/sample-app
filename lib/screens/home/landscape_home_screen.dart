import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/landscapeHomeViewModel.dart';
import 'package:bluebellapp/models/page_view_data.dart';
import 'package:bluebellapp/models/quick_link_data.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/landscape/landscape_main_service_card.dart';
import 'package:bluebellapp/screens/landscape/quick_link_card.dart';
import 'package:bluebellapp/screens/product_detail/product_inquiry_tab.dart';
import 'package:bluebellapp/screens/shared/category_home_screen.dart';
import 'package:bluebellapp/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class LandscapeHomeScreen extends StatefulWidget {
  @override
  _LandscapeHomeScreenState createState() => _LandscapeHomeScreenState();
}

class _LandscapeHomeScreenState extends State<LandscapeHomeScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController animationController;
  LandscapeHomeViewModel landscapeHomeViewModel;
  Size size;

  @override
  void initState() {
    if (mounted) {
      animationController = AnimationController(
          duration: Duration(milliseconds: 400), vsync: this);
    }
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<SliderViewDto> getSliderContentList() {
    return landscapeHomeViewModel.banners
        .map((e) => SliderViewDto(
            titleText: e.title,
            subText: e.title,
            assetsImage: e.bannerUrl,
            onClick: () {
              context
                  .addEvent(LandscapeServiceDetailScreenEvent(guid: e.seName));
            }))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    landscapeHomeViewModel =
        context.getAppScreenBloc().data as LandscapeHomeViewModel;
    size = MediaQuery.of(context).size;
    var body = List<Widget>();
    body.add(getMainServices());
    body.add(getQuickLinks());
    var containerBody = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: body,
    );
    return CategoryHomeScreen(
      sliderContentList: getSliderContentList(),
      body: containerBody.children,
      //animationController: animationController,
      showSearchBar: false,
      scaffoldKey: scaffoldKey,
      showBackButton: true,
      screenTitle: GeneralStrings.LANDSCAPE_TITLE,
    );
  }

  getMainServices() {
    var services = List<Widget>();
    services = landscapeHomeViewModel.services
        .map((e) => LandscapeMainServiceCard(
              serviceInfo: e,
              height: size.width / 2 - 16,
              onTap: () {
                context.addEvent(
                    LandscapeServiceDetailScreenEvent(guid: e.seName));
              },
            ))
        .toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(GeneralStrings.LANDSCAPES_FOR_LIVING,
                style: TextConstants.H4.apply(color: LightColor.navy))
            .padding(EdgeInsets.only(left: 8)),
        LayoutConstants.sizedBox15H,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getGridRowsList(2, services, size.width),
        ),
        LayoutConstants.sizedBox20H
      ],
    );
  }

  getQuickLinks() {
    var width = size.width / 3 - 16;
    var quickLinkCards = QuickLinkData.getQuickLinkListData().map((e) {
      return getQuickLinkList(e, width);
    }).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(GeneralStrings.QUICK_LINKS,
                style: TextConstants.H4.apply(color: LightColor.navy))
            .padding(EdgeInsets.only(left: 8)),
        LayoutConstants.sizedBox15H,
        Row(children: quickLinkCards.sublist(0, 3)),
        SizedBox(
          height: 8,
        ),
        Row(children: quickLinkCards.sublist(3, 5)),
        LayoutConstants.sizedBox20H,
      ],
    );
  }

  QuickLinkCard getQuickLinkList(QuickLinkData e, double width) {
    return QuickLinkCard(
      imagePath: e.imagePath,
      title: e.title,
      width: width,
      isQuote: e.title == "Get Quote" ? true : false,
      onTap: () {
        if (e.title == "Get Quote") {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: size.height * 0.12,
                child: ProductInquiryTab(
                  height: size.height * 0.1 +
                      (Device.get().isTablet
                          ? MediaQuery.of(context).padding.bottom
                          : 0),
                  onFormClick: () {
                    Navigator.pop(context);
                    context.addEvent(ContactUsFormScreenEvent());
                  },
                  onButtonClick: () {
                    Navigator.pop(context);
                  },
                  buttonColor: LightColor.landGreen,
                ),
              );
            },
          );
        } else {
          context.addEvent(e.event);
        }
      },
    );
  }
}
