import 'package:bluebellapp/models/hotelListData.dart';
import 'package:bluebellapp/models/page_view_data.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/shared/_header_slider_view.dart';
import 'package:bluebellapp/screens/shared/_safe_area_screen.dart';
import 'package:flutter/material.dart';
import '_layout_screen_updated.dart';
import '../widgets/helper_widgets/search_bar.dart';

// ignore: must_be_immutable
class SliderLayoutScreen extends StatefulWidget {
  final AnimationController animationController;
  final List<Widget> body;
  final List<SliderViewDto> sliderContentList;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final showBackButton;
  bool showSearchButton = false;
  bool showSearchBar = true;

  SliderLayoutScreen(
      {Key key,
      this.animationController,
      this.body,
      this.sliderContentList,
      this.scaffoldKey,
      this.showBackButton,
      this.showSearchButton,
      this.showSearchBar})
      : super(key: key);
  @override
  _SliderLayoutScreenState createState() => _SliderLayoutScreenState();
}

class _SliderLayoutScreenState extends State<SliderLayoutScreen>
    with TickerProviderStateMixin {
  var hotelList = HotelListData.hotelList;
  ScrollController controller;
  AnimationController _animationController;
  bool dataInitialized = false;
  var sliderImageHeight = 0.0;
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  Size size;

  initializeData() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    if (mounted && widget.animationController != null) {
      widget.animationController.forward();
    }
    controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
      if (context != null) {
        if (controller.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (controller.offset > 0.0 &&
            controller.offset < sliderImageHeight) {
          // we need around half scrolling values
          if (controller.offset < ((sliderImageHeight / 1.5))) {
            _animationController
                .animateTo((controller.offset / sliderImageHeight));
          } else {
            // we static set the just above half scrolling values "around == 0.64"
            _animationController
                .animateTo((sliderImageHeight / 1.5) / sliderImageHeight);
          }
        }
      }
    });
    dataInitialized = true;
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    if (dataInitialized == false) {
      initializeData();
      dataInitialized = true;
    }
    sliderImageHeight = size.height * 0.4825;
    var body = AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return SafeAreaScreen(
          child: Transform(
            transform: new Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animationController.value), 0.0),
            child: SafeArea(
              child: Scaffold(
                key: widget.scaffoldKey,
                // backgroundColor: ThemeScheme.lightTheme.primaryColor,
                body: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        //  color: AppTheme.getTheme().backgroundColor,
                        child: ListView.builder(
                          controller: controller,
                          itemCount: widget.body.length,
                          // padding on top is only for we need spec for slider
                          padding: EdgeInsets.only(
                              top: sliderImageHeight + 30, bottom: 16),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return widget.body[index];
                          },
                        ),
                      ),
                    ),

                    // sliderUI with 3 images are moving
                    _sliderUI(),

                    // viewHotels Button UI for click event
                    //_viewHotelsButton(_animationController),

                    //just gradient for see the time and battery Icon on "TopBar"
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            AppTheme.lightTheme.backgroundColor
                                .withOpacity(0.4),
                            AppTheme.lightTheme.backgroundColor
                                .withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                      ),
                    ),
                    // searchUI on Top  Positioned
                    widget.showSearchBar == true
                        ? Positioned(
                            top: MediaQuery.of(context).padding.top,
                            left: 0,
                            right: 0,
                            child: searchUI(),
                          )
                        : Text('')
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return LayoutScreen(
      animationController: widget.animationController,
      childView: body,
      showAppbar: false,
      scaffoldKey: scaffoldKey1,
      showBackButton: widget.showBackButton ?? false,
      addSearchButton: widget.showSearchButton,
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
          // we calculate the opacity between 0.64 to 1.0
          var opacity = 1.0 -
              (_animationController.value > 0.64
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: sliderImageHeight * (1.0 - _animationController.value),
            child: HeaderSliderView(
                opValue: opacity,
                click: () {},
                pageViewModelData: widget.sliderContentList,
                imageHeight: sliderImageHeight),
          );
        },
      ),
    );
  }

  Widget searchUI() {
    return SearchBar();
  }

  // Widget _viewHotelsButton(AnimationController _animationController) {
  //   return AnimatedBuilder(
  //     animation: _animationController,
  //     builder: (BuildContext context, Widget child) {
  //       var opacity = 1.0 -
  //           (_animationController.value > 0.64
  //               ? 1.0
  //               : _animationController.value);
  //       return Positioned(
  //         left: 0,
  //         right: 0,
  //         top: 0,
  //         height: sliderImageHeight * (1.0 - _animationController.value),
  //         child: Stack(
  //           children: <Widget>[
  //             Positioned(
  //               bottom: 32,
  //               left: 24,
  //               child: Opacity(
  //                 opacity: opacity,
  //                 child: Container(
  //                   height: 48,
  //                   decoration: BoxDecoration(
  //                     color: ThemeScheme.lightTheme.primaryColor,
  //                     borderRadius: BorderRadius.all(Radius.circular(24.0)),
  //                     boxShadow: <BoxShadow>[
  //                       BoxShadow(
  //                         // color: AppTheme.getTheme().dividerColor,
  //                         blurRadius: 8,
  //                         offset: Offset(4, 4),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Material(
  //                     color: Colors.transparent,
  //                     child: InkWell(
  //                       borderRadius: BorderRadius.all(Radius.circular(24.0)),
  //                       highlightColor: Colors.transparent,
  //                       onTap: () {
  //                         if (opacity != 0) {
  //                           // Navigator.push(
  //                           //   context,
  //                           //   //MaterialPageRoute(builder: (context) => HotelHomeScreen()),
  //                           // );
  //                         }
  //                       },
  //                       child: Center(
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(
  //                               left: 24, right: 24, top: 8, bottom: 8),
  //                           child: Text(
  //                             "View Hotels",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.w500,
  //                                 fontSize: 16,
  //                                 color: Colors.white),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
