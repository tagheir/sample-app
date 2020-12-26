import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/models/hotelListData.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/theme_scheme.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../explore/homeExploreSliderView.dart';
import 'main_category_card.dart';

class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeExploreScreen({Key key, this.animationController})
      : super(key: key);
  @override
  _HomeExploreScreenState createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen>
    with TickerProviderStateMixin {
  var hotelList = HotelListData.hotelList;
  ScrollController controller;
  AnimationController _animationController;
  var sliderImageHieght = 0.0;
  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);

    controller.addListener(() {
      if (context != null) {
        if (controller.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (controller.offset > 0.0 &&
            controller.offset < sliderImageHieght) {
          // we need around half scrolling values
          if (controller.offset < ((sliderImageHieght / 1.5))) {
            _animationController
                .animateTo((controller.offset / sliderImageHieght));
          } else {
            // we static set the just above half scrolling values "around == 0.64"
            _animationController
                .animateTo((sliderImageHieght / 1.5) / sliderImageHieght);
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHieght = MediaQuery.of(context).size.width * 1.3;
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animationController,
          // FadeTransition and Transform : just for screen loading animation on fistTime
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animationController.value), 0.0),
            child: Scaffold(
              // backgroundColor: ThemeScheme.lightTheme.primaryColor,
              body: Stack(
                children: <Widget>[
                  Container(
                    //  color: AppTheme.getTheme().backgroundColor,
                    child: ListView.builder(
                      controller: controller,
                      itemCount: 4,
                      // padding on top is only for we need spec for sider
                      padding: EdgeInsets.only(
                          top: sliderImageHieght + 30, bottom: 16),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      MainCategoryCard(
                                        backgroundColor: Colors.blue.shade100,
                                        title: 'Facility Management',
                                        icon: Icon(
                                          Icons.home,
                                          color: Colors.blueAccent[700],
                                          size: 100,
                                        ),
                                        onClick: () {
                                          context.addEvent(
                                              ServicesHomeScreenEvent());
                                        },
                                      ),
                                      LayoutConstants.sizedBox20W,
                                      MainCategoryCard(
                                        backgroundColor: Colors.green.shade100,
                                        title: 'Landscape',
                                        icon: Icon(
                                          Icons.landscape,
                                          color: Colors.green[700],
                                          size: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    children: <Widget>[
                                      MainCategoryCard(
                                        backgroundColor: Colors.orange.shade100,
                                        title: 'eStore',
                                        icon: Icon(
                                          Icons.store,
                                          color: ThemeScheme
                                              .lightTheme.primaryColor,
                                          size: 100,
                                        ),
                                        onClick: () {
                                          context
                                              .addEvent(StoreHomeScreenEvent());
                                        },
                                      ),
                                      LayoutConstants.sizedBox20W,
                                      MainCategoryCard(
                                        backgroundColor: Colors.yellow[100],
                                        title: 'Maintainance Packages',
                                        icon: Icon(
                                          Icons.card_giftcard,
                                          color: Colors.yellow[700],
                                          size: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  // sliderUI with 3 images are moving
                  _sliderUI(),

                  // viewHotels Button UI for click event
                  _viewHotelsButton(_animationController),

                  //just gradient for see the time and battry Icon on "TopBar"
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          AppTheme.lightTheme.backgroundColor.withOpacity(0.4),
                          AppTheme.lightTheme.backgroundColor.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                    ),
                  ),
                  // serachUI on Top  Positioned
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 0,
                    right: 0,
                    child: serachUI(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _viewHotelsButton(AnimationController _animationController) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        var opecity = 1.0 -
            (_animationController.value > 0.64
                ? 1.0
                : _animationController.value);
        return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: sliderImageHieght * (1.0 - _animationController.value),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 32,
                left: 24,
                child: Opacity(
                  opacity: opecity,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: ThemeScheme.lightTheme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          // color: AppTheme.getTheme().dividerColor,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (opecity != 0) {
                            // Navigator.push(
                            //   context,
                            //   //MaterialPageRoute(builder: (context) => HotelHomeScreen()),
                            // );
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 8),
                            child: Text(
                              "View Hotels",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sliderUI() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          // we calculate the opecity between 0.64 to 1.0
          var opecity = 1.0 -
              (_animationController.value > 0.64
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: sliderImageHieght * (1.0 - _animationController.value),
            child: HomeExploreSliderView(
              opValue: opecity,
              click: () {},
            ),
          );
        },
      ),
    );
  }

  // Widget getDealListView(int index) {
  //   var hotelList = HotelListData.hotelList;
  //   List<Widget> list = List<Widget>();
  //   hotelList.forEach((f) {
  //     var animation = Tween(begin: 0.0, end: 1.0).animate(
  //       CurvedAnimation(
  //         parent: widget.animationController,
  //         curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn),
  //       ),
  //     );
  //     list.add(
  //       HotelListView(
  //         callback: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => HotelDetailes(
  //                       hotelData: f,
  //                     ),
  //                 fullscreenDialog: true),
  //           );
  //         },
  //         hotelData: f,
  //         animation: animation,
  //         animationController: widget.animationController,
  //       ),
  //     );
  //   });
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8),
  //     child: Column(
  //       children: list,
  //     ),
  //   );
  // }

  Widget serachUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeScheme.lightTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(
            color: HexColor("#757575").withOpacity(0.6),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.lightTheme.dividerColor,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(38)),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SearchScreen(), fullscreenDialog: true),
                  // );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.search,
                      size: 18,
                      //color: AppTheme.getTheme().primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => SearchScreen(), fullscreenDialog: true),
                        //   );
                        // },
                        enabled: false,
                        onChanged: (String txt) {},
                        style: TextStyle(
                          fontSize: 16,
                          color: LightColor.darkGrey,
                        ),
                        cursorColor: ThemeScheme.lightTheme.primaryColor,
                        decoration: new InputDecoration(
                          errorText: null,
                          border: InputBorder.none,
                          hintText: "Where are you going?",
                          hintStyle: TextStyle(
                              color: AppTheme.lightTheme.disabledColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
