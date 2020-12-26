import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/explore/main_category_card.dart';
import 'package:bluebellapp/models/dashboard_view_model.dart';
import 'package:bluebellapp/models/page_view_data.dart';
import 'package:bluebellapp/resources/constants/colors.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/new_version.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/text_widgets/general-text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class DashboardHomeScreen extends StatefulWidget {
  DashboardHomeScreen();
  @override
  _DashboardHomeScreenState createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  DashBoardViewModel dashBoardViewModel;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  NewVersion newVersion;

  @override
  void initState() {
    //  Admob.requestTrackingAuthorization();
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    super.initState();
  }

  updateAppNotification() async {
    if (context.getAppBloc().isFirstTimeLoad) {
      final status = await newVersion.getVersionStatus();
      //print(status.canUpdate);
      //print(status.localVersion);
      //print(status.storeVersion);
      newVersion.showAlertIfNecessary();
      context.getAppBloc().isFirstTimeLoad = false;
    }
  }

  List<SliderViewDto> getSliderContentList() {
    return dashBoardViewModel.banners
        .map((e) => SliderViewDto(
            titleText: e.title,
            subText: e.title,
            assetsImage: e.bannerUrl,
            onClick: () {
              if (e.seName == GeneralStrings.FACILITY_MANAGEMENT)
                context.addEvent(ServicesHomeScreenEvent());
              if (e.seName == GeneralStrings.LANDSCAPE)
                context.addEvent(LandscapeHomeScreenEvent());
              if (e.seName == GeneralStrings.E_STORE)
                context.addEvent(StoreHomeScreenEvent());
            }))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    newVersion = NewVersion(context: context);
    dashBoardViewModel = context.getAppScreenBloc().data as DashBoardViewModel;
    updateAppNotification();
    var body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getHeader(),
        getMiddleContent(context),
        getFooter(context),
      ],
    );

    return LayoutScreen(
      backgroundColor: Colors.black,
      backgroundImagePath: "assets/images/bg-black.jpg",
      showAppbar: false,
      showBackButton: false,
      childView: body,
      scaffoldKey: scaffoldKey,
      showNavigationBar: false,
      setSafeArea: true,
      showFloatingButton: false,
    );
  }

  Widget getHeader() {
    return Image.asset(
      'assets/images/logo.png',
      width: AppTheme.deviceWidth * 0.35,
    ).padding(EdgeInsets.only(
      left: 30,
      top: 40,
    ));
  }

  Widget getFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getFooterIcon(context, FontAwesomeIcons.shoppingCart, "Cart",
            CartItemsViewEvent()),
        getFooterIcon(context, FontAwesomeIcons.user, "Profile",
            CustomerProfileViewEvent()),
      ],
    ).padding(EdgeInsets.only(bottom: 20));
  }

  Widget getFooterIcon(
      BuildContext context, IconData icon, String text, AppEvent evt) {
    return InkWell(
      onTap: () => context.addEvent(evt),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget getMiddleContent(BuildContext context) {
    var body = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GeneralText(
          "Give something wonderful",
          color: Colors.white,
          fontSize: AppTheme.deviceWidth * 0.0645,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        LayoutConstants.sizedBox50H,
        getIconsRow(context),
      ],
    );
    return body;
  }

  Widget getIconsRow(BuildContext context) {
    var iconsRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        getCategoryCardUpdate(
          context,
          'Facilities Management',
          "assets/images/icons/fm-icon.png",
          Colors.white,
          ServicesHomeScreenEvent(),
          borderColor: BBColors.orangeColor.withOpacity(0),
          textColor: Colors.white,
        ),
        LayoutConstants.sizedBox20H,
        getCategoryCardUpdate(
          context,
          'Landscape',
          "assets/images/icons/landscape-icon-updated.png",
          Colors.white,
          LandscapeHomeScreenEvent(),
          borderColor: BBColors.greenColor.withOpacity(0),
          textColor: Colors.white,
        ),
        LayoutConstants.sizedBox20H,
        getCategoryCardUpdate(
          context,
          'eStore',
          "assets/images/icons/estore-wicon.png",
          Color(0xff062d66),
          StoreHomeScreenEvent(),
          textColor: Colors.white,
          borderColor: Colors.white.withOpacity(0),
        ),
      ],
    ).center().padding(EdgeInsets.all(20));
    return iconsRow;
  }

  getCategoryCard(BuildContext context, String title, IconData icon,
      MaterialColor color, AppEvent event,
      {bool opacity}) {
    return MainCategoryCard(
      backgroundColor: color.shade100,
      addOpacity: opacity,
      title: title,
      icon: Icon(
        icon,
        color: color.shade700,
        size: 100,
      ),
      onClick: () {
        if (event != null) {
          context.addEvent(event);
        }
      },
    );
  }

  getCategoryCardUpdate(
    BuildContext context,
    String title,
    String iconPath,
    Color color,
    AppEvent event, {
    Color borderColor,
    bool opacity,
    Color textColor = LightColor.lightBlack,
  }) {
    return MainCategoryCard(
      backgroundColor: color,
      borderColor: borderColor,
      addOpacity: true,
      title: title,
      icon: null,
      imagePath: iconPath,
      textColor: textColor,
      onClick: () {
        if (event != null) {
          context.addEvent(event);
        }
      },
    );
  }
}
