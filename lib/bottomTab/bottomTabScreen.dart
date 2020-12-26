import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/explore/homeExplore.dart';
import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';


class BottomTabScreen extends StatefulWidget {
  final Widget childView;
  BottomTabScreen({
    this.childView
  });
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  bool isFirstTime = true;
  Widget indexView = Container();
  BottomBarType bottomBarType = BottomBarType.Explore;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      isFirstTime = false;
      if(widget.childView == null){
        indexView = HomeExploreScreen(
        animationController: animationController,
      );
      }
      else{
        indexView = widget.childView;
      }
    });
    animationController..forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: ThemeScheme.lightTheme.backgroundColor,
        bottomNavigationBar: Container(height: 70 + MediaQuery.of(context).padding.bottom, child: getBottomBarUI(bottomBarType)),
        body: isFirstTime
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : indexView,
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController.reverse().then((f) {
        if (tabType == BottomBarType.Explore) {
          setState(() {
            indexView = HomeExploreScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Trips) {
          var token = context.getAppBloc().getRepo().getToken();
            if(token != null){
              context.addEvent(CartItemsViewEvent());
            }
            else{
              context.addEvent(LoginScreenEvent());
            }
        } else if (tabType == BottomBarType.Profile) {
              context.addEvent(CustomerProfileViewEvent());
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
                    splashColor: ThemeScheme.lightTheme.primaryColor.withOpacity(0.2),
                    onTap: () {
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
                            color: tabType == BottomBarType.Explore ? ThemeScheme.lightTheme.primaryColor : AppTheme.lightTheme.disabledColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Explore",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: tabType == BottomBarType.Explore ? ThemeScheme.lightTheme.primaryColor : AppTheme.lightTheme.disabledColor),
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
                    splashColor: AppTheme.lightTheme.primaryColor.withOpacity(0.2),
                    onTap: () {
                      tabClick(BottomBarType.Trips);
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
                            FontAwesomeIcons.shoppingCart,
                            color: tabType == BottomBarType.Trips ? ThemeScheme.lightTheme.primaryColor : AppTheme.lightTheme.disabledColor,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Cart",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: tabType == BottomBarType.Trips ? ThemeScheme.lightTheme.primaryColor : AppTheme.lightTheme.disabledColor),
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
                    splashColor: ThemeScheme.lightTheme.primaryColor.withOpacity(0.2),
                    onTap: () {
                      tabClick(BottomBarType.Profile);
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
                            FontAwesomeIcons.user,
                            color: tabType == BottomBarType.Profile ? ThemeScheme.lightTheme.primaryColor : AppTheme.lightTheme.disabledColor,
                            size: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: tabType == BottomBarType.Profile ? ThemeScheme.lightTheme.primaryColor : AppTheme.lightTheme.disabledColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

enum BottomBarType { Explore, Trips, Profile }
