import 'dart:io';

import 'package:bluebellapp/app.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/landscape/quote_button.dart';
import 'package:bluebellapp/screens/product_detail/product_inquiry_tab.dart';
import 'package:bluebellapp/screens/shared/move_back_button.dart';
import 'package:bluebellapp/screens/shared/on_screen_loading.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_shadow/icon_shadow.dart';

class LayoutScreen extends StatefulWidget {
  final String screenTitle;
  final Widget childView;
  final Color backgroundColor;
  final String backgroundImagePath;
  final Color moveBackBtnColor;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BottomBarType bottomBarType;
  AnimationController animationController;
  final AppState returnState;
  bool showNavigationBar;
  bool showAppbar = false;
  bool showQuoteButton;
  bool showBannerImage = false;
  final String bannerImagePath;
  final bool isAppScreenBloc;
  bool showBackButton;
  bool addBackButton;
  bool addSearchButton = false;
  bool handleGesture;
  FloatingActionButton floatingActionButton;
  bool showSearchBar;
  bool showFilterIcon;
  bool showHeaderProfileIcon;
  bool showHeaderHomeIcon;
  final bool setSafeArea;
  Function onFilterIconPress;
  Function(String) onSearchSubmit;
  Widget bottomBar;
  bool showFloatingButton;

  final Color screenTitleColor;

  final bool showHeaderCartButton;
  LayoutScreen({
    this.childView,
    this.screenTitle,
    this.backgroundColor,
    this.moveBackBtnColor,
    this.animationController,
    this.scaffoldKey,
    this.bottomBarType,
    this.returnState,
    this.showAppbar,
    this.bottomBar,
    this.handleGesture,
    this.showQuoteButton,
    this.showHeaderCartButton = false,
    this.showBannerImage,
    this.bannerImagePath,
    this.showNavigationBar,
    this.backgroundImagePath,
    this.showBackButton,
    this.addBackButton,
    this.showSearchBar,
    this.setSafeArea = false,
    this.showFilterIcon,
    this.onFilterIconPress,
    this.onSearchSubmit,
    this.floatingActionButton,
    this.addSearchButton,
    this.isAppScreenBloc = false,
    this.screenTitleColor = Colors.white,
    this.showFloatingButton = true,
    this.showHeaderProfileIcon = true,
    this.showHeaderHomeIcon = true,
  });
  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool isFirstTime = true;
  bool dataInitialized = false;
  bool isDisposed = false;
  Widget indexView = Container();
  BottomBarType bottomBarType;
  Size size;
  App appBloc;
  bool absorbing = false;
  bool handleGesture;
  Widget floatingButton;

  @override
  void initState() {
    indexView = Container();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      isFirstTime = false;
      if (widget.childView == null) {
        indexView = Container(child: Text("No Data"));
      } else {
        indexView = widget.childView;
      }
    });
  }

  initializeData() {
    handleGesture = widget.handleGesture ?? true;
    appBloc = context.getAppBloc();
    animationController = widget.animationController ??
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    bottomBarType = widget.bottomBarType ?? BottomBarType.Explore;
    size = MediaQuery.of(context).size;
    if (mounted) {
      animationController..forward();
    }
  }

  Widget getBannerImageWidget() {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      height: AppTheme.deviceWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(bottom: LayoutConstants.borderRadius8)),
      child: ClipRRect(
          borderRadius:
              BorderRadius.vertical(bottom: LayoutConstants.borderRadius8),
          child: ContainerCacheImage(
            altImageUrl: "https://placehold.it/600",
            imageUrl: widget.bannerImagePath,
            fit: BoxFit.cover,
          )),
    );
  }

  getAppBar() {
    // var appBarHeight = kToolbarHeight + 6;
    // return PreferredSize(
    //   preferredSize: Size.fromHeight(appBarHeight),
    //   child: new AppBar(
    //     flexibleSpace: SizedBox(
    //       height: appBarHeight,
    //     ),
    //     title: new Text(
    //       "WhatsApp",
    //       style: TextStyle(
    //           color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w600),
    //     ),
    //     actions: <Widget>[
    //       Padding(
    //         padding: const EdgeInsets.only(right: 20.0),
    //         child: Icon(Icons.search),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(right: 16.0),
    //         child: Icon(Icons.more_vert),
    //       ),
    //     ],
    //     backgroundColor: Colors.green,
    //   ),
    // );

    return AppBar(
      toolbarHeight: 60,
      title: Text(widget.screenTitle ?? '',
          style: TextConstants.H5.apply(color: widget.screenTitleColor)),
      //centerTitle: true,
      backgroundColor: AppTheme.lightTheme.primaryColor,
      // shape: CustomShapeBorder(height: this.height, width: this.width),
      leading: MoveBackButton(
        scaffoldKey: widget.scaffoldKey,
        color: LightColor.white,
      ),
      actions: LayoutConstants.getAppBarActions(
        widget.scaffoldKey?.currentContext ?? App.get().currentContext,
        showProfileIcon: widget.showHeaderProfileIcon ?? true,
        showHomeIcon: widget.showHeaderHomeIcon ?? true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.showNavigationBar = widget.showNavigationBar ?? true;
    widget.showBackButton = widget.showBackButton ?? false;
    widget.showSearchBar = widget.showSearchBar ?? false;
    widget.showFloatingButton = widget.showFloatingButton ?? true;
    if (widget.isAppScreenBloc == true) {
      if (context.getAppScreenBloc().onScreenLoadingFunction == null) {
        context.getAppScreenBloc().onScreenLoadingFunction = (bool status) {
          setState(() {
            context.getAppScreenBloc().onScreenLoading = status;
          });
        };
      }
    }
    if (dataInitialized == false) {
      initializeData();
      dataInitialized = true;
    }
    startLoadScreen();
    List<Widget> stackWidgets = List<Widget>();
    List<Widget> bodyWidget = List<Widget>();
    if (widget.showBannerImage == true) {
      stackWidgets.add(Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                Column(
                  children: [
                    getBannerImageWidget(),
                    indexView,
                  ],
                )
              ],
            ),
          ),
        ],
      ));
    }

    if (widget.showSearchBar) {
      bodyWidget.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SearchBar(
                showFilterIcon: widget.showFilterIcon,
                onFilterIconPress: widget.onFilterIconPress,
                onSearchSubmit: (str) {
                  widget.onSearchSubmit(str);
                },
              ),
            )
          ]));
    }

    if (widget.addBackButton == true && widget.showAppbar != true) {
      // print("==== add back button ====");

      bodyWidget.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: MediaQuery.of(context).padding.top + size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: widget.showSearchBar == true ? 1 : 0,
                child: MoveBackButton(
                  scaffoldKey: widget.scaffoldKey,
                  color: AppTheme.lightTheme.primaryColor,
                  returnState: widget.returnState,
                ).padding(EdgeInsets.only(
                    left: 8, top: widget.showSearchBar == true ? 16 : 0)),
              ),
              // Spacer(),
              // Row(
              //   children: [profileIcon ?? Text(''), homeIcon],
              // ),
              // widget.showSearchBar == true
              //     ? Expanded(
              //         flex: 15,
              //         child: SearchBar(
              //           showFilterIcon: widget.showFilterIcon,
              //           onFilterIconPress: widget.onFilterIconPress,
              //           onSearchSubmit: (str) {
              //             widget.onSearchSubmit(str);
              //           },
              //         ),
              //       )
              //     :
              Text(
                widget.screenTitle ?? '',
                style: TextStyle(
                  color: widget.screenTitleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).padding(EdgeInsets.only(left: 8))
            ],
          ),
        ],
      ));
    }
    if (widget.showBannerImage == null) {
      bodyWidget.add(Expanded(
        child: indexView,
      ));
    }

    stackWidgets.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: bodyWidget,
      ),
    );

    if (widget.showBackButton == true) {
      stackWidgets.add(
        Positioned(
            top: size.height * 0.04,
            child: MoveBackButton(
              scaffoldKey: widget.scaffoldKey,
              color:
                  widget.moveBackBtnColor ?? AppTheme.lightTheme.primaryColor,
            )),
      );
    }

    if (widget.addSearchButton == true) {
      stackWidgets.add(Positioned(
        top: size.height * 0.04,
        right: 0,
        child: IconButton(
          icon: Icon(
            Icons.search,
            color: AppTheme.lightTheme.primaryColor,
            size: 35,
          ),
          onPressed: () {
            appBloc.add(StoreSearchEvent());
          },
        ),
      ));
    }

    if (widget.showQuoteButton == true) {
      stackWidgets.add(Positioned(
          top: -(size.height * 0.03),
          right: size.width * 0.05,
          child: GetQuoteButton(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return ProductInquiryTab(
                    height: size.height * 0.1 +
                        (Device.get().isTablet
                            ? MediaQuery.of(context).padding.bottom
                            : 0),
                    onFormClick: () {
                      Navigator.pop(context);
                      context.addEvent(ContactUsFormScreenEvent());
                    },
                    buttonColor: LightColor.landGreen,
                  );
                },
              );
            },
          )));
    }
    if (widget.isAppScreenBloc == true) {
      if (context.getAppScreenBloc().onScreenLoading) {
        absorbing = true;
        stackWidgets.add(OnScreenLoading(size: size));
      } else if (!context.getAppScreenBloc().onScreenLoading) {
        absorbing = false;
      }
    }

    if (widget.bottomBar != null) {
      stackWidgets.add(Positioned(bottom: 0, child: widget.bottomBar));
    }

    if (widget.showFloatingButton) {
      floatingButton = FloatingActionButton(
        backgroundColor: AppTheme.lightTheme.primaryColor,
        onPressed: () {
          context.getAppBloc().add(CartItemsViewEvent());
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      );
    }

    var absorbPointer = AbsorbPointer(
      absorbing: absorbing,
      child: widget.setSafeArea == true
          ? Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top +
                      MediaQuery.of(context).padding.top * 0.3),
              child: Stack(children: stackWidgets))
          : Stack(children: stackWidgets),
    );
    var coreBody = widget.backgroundImagePath == null
        ? absorbPointer
        : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: absorbPointer,
          );
    var scaffold = Scaffold(
        key: widget.scaffoldKey,

        // resizeToAvoidBottomInset: false,
        appBar: widget.showAppbar == true ? getAppBar() : null,
        backgroundColor: widget.backgroundColor == null
            ? ThemeScheme.lightTheme.backgroundColor
            : widget.backgroundColor,
        floatingActionButton: widget.floatingActionButton ?? floatingButton,
        // bottomNavigationBar: widget.showNavigationBar == true
        //     ? Container(
        //         height: size.height * 0.1 +
        //             (Device.get().isTablet
        //                 ? MediaQuery.of(context).padding.bottom
        //                 : 0),
        //         child: getBottomBarUI(bottomBarType))
        //     : null,
        body: coreBody);
    // //print(MediaQuery.of(context).padding.top);
    // //print(MediaQuery.of(context).padding.top * 0.3);
    if (Platform.isIOS && handleGesture) {
      return GestureDetector(
        child: scaffold,
        onPanUpdate: (dis) {
          if (dis.delta.dx > 0) {
            //User swiped from left to right
            appBloc.moveBack(context);
          }
        },
        // onSwipeRight: () {
        //   appBloc.moveBack(context);
        // },
      );
    } else {
      return scaffold;
    }
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController.reverse().then((f) {
        if (tabType == BottomBarType.Explore) {
          context.addEvent(DashboardScreenEvent());
          setState(() {
            indexView = widget.childView;
          });
        } else if (tabType == BottomBarType.Cart) {
          var token = context.getAppBloc().getRepo().getToken();

          if (token != null) {
            context.addEvent(CartItemsViewEvent());
          } else {
            context.addEvent(LoginScreenEvent());
          }
        } else if (tabType == BottomBarType.Profile) {
          context.addEvent(CustomerProfileViewEvent(
              animationController: animationController));
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeScheme.lightTheme.backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.lightTheme.dividerColor,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor:
                        ThemeScheme.lightTheme.primaryColor.withOpacity(0.2),
                    onTap: () {
                      setState(() {
                        tabType = BottomBarType.Explore;
                      });
                      tabClick(BottomBarType.Explore);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          child: Icon(
                            Icons.search,
                            size: 26,
                            color: tabType == BottomBarType.Explore
                                ? AppTheme.lightTheme.primaryColor
                                : AppTheme.lightTheme.disabledColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Explore",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: tabType == BottomBarType.Explore
                                    ? AppTheme.lightTheme.primaryColor
                                    : AppTheme.lightTheme.disabledColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor:
                        AppTheme.lightTheme.primaryColor.withOpacity(0.2),
                    onTap: () {
                      setState(() {
                        tabType = BottomBarType.Cart;
                      });
                      tabClick(BottomBarType.Cart);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            FontAwesomeIcons.shoppingCart,
                            color: tabType == BottomBarType.Cart
                                ? AppTheme.lightTheme.primaryColor
                                : AppTheme.lightTheme.disabledColor,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Cart",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: tabType == BottomBarType.Cart
                                    ? AppTheme.lightTheme.primaryColor
                                    : AppTheme.lightTheme.disabledColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor:
                        AppTheme.lightTheme.primaryColor.withOpacity(0.2),
                    onTap: () {
                      setState(() {
                        tabType = BottomBarType.Profile;
                      });
                      tabClick(BottomBarType.Profile);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: tabType == BottomBarType.Profile
                                ? AppTheme.lightTheme.primaryColor
                                : AppTheme.lightTheme.disabledColor,
                            size: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: tabType == BottomBarType.Profile
                                    ? AppTheme.lightTheme.primaryColor
                                    : AppTheme.lightTheme.disabledColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).padding.bottom,
          // )
        ],
      ),
    );
  }
}

enum BottomBarType { Explore, Cart, Profile }

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final double innerCircleRadius = 120.0;

    Path path = Path();
    path.moveTo(0, innerCircleRadius - 40);
    path.quadraticBezierTo(
        440 / 2, innerCircleRadius, 440, innerCircleRadius - 40);
    path.lineTo(440, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }
}
