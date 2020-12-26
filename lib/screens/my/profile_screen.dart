import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/category_info_dto.dart';
import 'package:bluebellapp/models/customer_dto.dart';
import 'package:bluebellapp/models/settingListData.dart';
import 'package:bluebellapp/resources/constants/app_routes.dart';
import 'package:bluebellapp/resources/strings/general_string.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_layout_screen_updated.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;

  const ProfileScreen({Key key, this.animationController}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SettingsListData> userSettingsList;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  App appBloc;
  CustomerDto myInfo;
  bool isUserLoggedIn = false;
  BuildContext screenContext;
  bool widgetRebuild = false;
  //AppState currentState;

  initialize() {
    //print(screenContext);
    // if (App.get().currentState.rebuild == null) {
    //print("===Rebuild function null====");
    App.get().currentState.rebuild = () async {
      //print("==Rebuild==");
      //print(context);
      var data = (await context.getAppScreenBloc().screenData.getScreenData())
          .data as CustomerDto;
      ////print("Rebuild NN");
      setState(() {
        ////print("Rebuild INNER");
        widgetRebuild = true;
        myInfo = data;
      });
    };
    // } else {
    //print("===========rebuild function not null=========");
    //  }
    appBloc = context.getAppBloc();
    isUserLoggedIn = appBloc.isUserLoggedIn;
    userSettingsList = isUserLoggedIn == true
        ? SettingsListData.userAuthenticatedOptions
        : SettingsListData.userUnauthenticatedOptions;
    if (myInfo == null) {
      myInfo = context.getAppScreenBloc().data;
    }
  }

  logout() async {
    await App.get().getRepo().getUserRepository().deleteToken();
    setState(() {
      App.get().isUserLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ////print("====is user logged in=====");
    screenContext = context;
    initialize();
    return LayoutScreen(
      bottomBarType: BottomBarType.Profile,
      scaffoldKey: scaffoldKey,
      childView: _getBody(context),
      addBackButton: true,
      showHeaderProfileIcon: true,
      showHeaderHomeIcon: true,
      showFloatingButton: false,
    );
  }

  _getBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(child: appBar()),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0.0),
            itemCount: userSettingsList.length,
            itemBuilder: (context, index) {
              var title = userSettingsList[index].titleTxt;
              return InkWell(
                onTap: () {
                  if (title == GeneralStrings.CHANGE_PASSWORD) {
                    context.addEvent(EmailOrPasswordVerificationScreenEvent(
                        isChangePassword: true));
                  }
                  if (title == GeneralStrings.MY_CART) {
                    context.addEvent(CartItemsViewEvent());
                  }
                  if (title == GeneralStrings.MY_ORDERS) {
                    context.addEvent(OrdersViewEvent());
                  }
                  if (title == GeneralStrings.PRIVACY_POLICY) {
                    launch(context.getCategoryType() == CategoryType.Landscape
                        ? AppRoutes.LandscapePrivacyPolicyLink
                        : AppRoutes.StorePrivacyPolicyLink);
                  }
                  if (title == GeneralStrings.TERMS_AND_CONDITIONS) {
                    launch(context.getCategoryType() == CategoryType.Landscape
                        ? AppRoutes.LandscapeTermsAndConditionsLink
                        : AppRoutes.StoreTermsAndConditionsLink);
                  }
                  if (title == GeneralStrings.HELP_CENTER) {
                    launch(AppRoutes.HelpCenterLink);
                  }
                  if (title == GeneralStrings.LOGOUT) {
                    // context.addEvent(LoggedOut());
                    logout();
                    myInfo = null;
                  }
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8, top: 8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                userSettingsList[index].titleTxt,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              child: Icon(userSettingsList[index].iconData,
                                  color: AppTheme.lightTheme.disabledColor
                                      .withOpacity(0.3)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
                      child: Divider(
                        height: 1,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
      //),
      //  ),
      // ),
    ).padding(EdgeInsets.all(8));
  }
  // );

  Widget appBar() {
    return InkWell(
      onTap: () {
        if (isUserLoggedIn == true) {
          context.addEvent(EditProfileEvent());
        } else {
          context.addEvent(LoginScreenEvent());
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isUserLoggedIn == true
                        ? "${myInfo?.firstName} ${myInfo?.lastName}"
                        : "Guest",
                    style: new TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    isUserLoggedIn == true
                        ? "View and edit profile"
                        : "Login / Create Account",
                    style: new TextStyle(
                      fontSize: 18,
                      color: AppTheme.lightTheme.disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 16, bottom: 16),
            child: Container(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                child: isUserLoggedIn != true
                    ? Image.asset("assets/images/profile.jpg")
                    : ContainerCacheImage(
                        altImageUrl: "https://placehold.it/200",
                        imageUrl: isUserLoggedIn == true
                            ? myInfo?.imageUrl
                            : "https://placehold.it/200",
                        fit: BoxFit.fill,
                        borderRadius: BorderRadius.circular(50.0),
                        rebuildImage: widgetRebuild,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
