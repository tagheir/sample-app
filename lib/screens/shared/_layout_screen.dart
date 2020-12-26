// import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
// import 'package:bluebellapp/resources/themes/light_color.dart';
// import 'package:bluebellapp/resources/themes/theme.dart';
// import 'package:bluebellapp/screens/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/app_background.dart';
// import 'package:bluebellapp/screens/widgets/views_widgets/drawer.dart';
// import 'package:flutter/material.dart';

// class LayoutScreenOld extends StatefulWidget {
//   final Widget body;
//   String searchQuery;
//   final bool defaultAppBar;
//   bool activateDrawer;
//   final bool isDashboardScreen;
//   final bool showSearchBar;
//   final bool showBottomNav;
//   final IconData leadingIcon;
//   final void Function() onLeadingIconPress;
//   final IconData actionIcon;
//   final Widget bottomBar;
//   final void Function() onActionIconPress;
//   final Future<void> Function() onRefresh;
//   final AppState returnState;
//   final bool showDefaultBackButton;
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final FloatingActionButton floatingActionButton;
//   LayoutScreenOld(
//       {Key key,
//       this.body,
//       this.defaultAppBar = true,
//       this.searchQuery,
//       this.showDefaultBackButton = false,
//       this.showSearchBar = false,
//       this.leadingIcon,
//       this.onLeadingIconPress,
//       this.actionIcon,
//       this.onActionIconPress,
//       this.scaffoldKey,
//       this.showBottomNav = true,
//       this.isDashboardScreen = false,
//       this.bottomBar,
//       this.onRefresh,
//       this.returnState,
//       this.floatingActionButton})
//       : super(key: key) {
//     if (activateDrawer == null) {
//       activateDrawer =
//           defaultAppBar && !showDefaultBackButton && leadingIcon == null;
//     }
//   }
//   @override
//   _LayoutScreenOldState createState() => _LayoutScreenOldState();
// }

// class _LayoutScreenOldState extends State<LayoutScreenOld> {
//   FocusNode _searchFocusNode = FocusNode();
//   GlobalKey<ScaffoldState> _scaffoldKey;
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       new GlobalKey<RefreshIndicatorState>();
//   double screenHeight, screenWidth;
//   bool isSearchFocused = false;
//   bool isCollapsed = true;
//   bool isHomePageSelected = true;
//   final Duration duration = const Duration(milliseconds: 200);

//   @override
//   void initState() {
//     super.initState();
//     _scaffoldKey = widget.scaffoldKey ?? GlobalKey();
//     if (widget.onRefresh != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (_refreshIndicatorKey?.currentState != null) {
//           _refreshIndicatorKey.currentState.show();
//         }
//       });
//     }
//     _searchFocusNode.addListener(_onFocusChange);
//   }

//   void _onFocusChange() {
//     debug////print("Focus: " + _searchFocusNode.hasFocus.toString());
//     setState(() {
//       isSearchFocused = _searchFocusNode.hasFocus;
//     });
//   }

//   Widget _appBar() {
//     var list = List<Widget>();
//     if (isSearchFocused) {
//       list.add(
//         Expanded(
//           flex: 1,
//           child: RotatedBox(
//             quarterTurns: 4,
//             child:
//                 _icon(Icons.arrow_back, color: Colors.black54, onPressed: () {
//               FocusScope.of(context).requestFocus(new FocusNode());
//             }),
//           ),
//         ),
//       );
//       list.add(Expanded(flex: 9, child: _search()));
//     } else {
//       if (widget.defaultAppBar ||
//           widget.showDefaultBackButton ||
//           widget.leadingIcon != null) {
//         var leadIcon;
//         if (widget.showDefaultBackButton) {
//           leadIcon =
//               _icon(Icons.arrow_back, color: Colors.black45, onPressed: () {
//             _scaffoldKey.currentContext
//                 .moveBack(returnState: widget.returnState);
//           });
//         } else if (widget.leadingIcon != null) {
//           leadIcon =
//               _icon(widget.leadingIcon, color: Colors.black45, onPressed: () {
//             if (widget.onLeadingIconPress != null) {
//               widget.onLeadingIconPress();
//             }
//           });
//         } else {
//           leadIcon = _icon(isCollapsed ? Icons.sort : Icons.arrow_back,
//               color: Colors.black, size: 25, onPressed: () {
//             if (isCollapsed == true) {
//               setState(() {
//                 isCollapsed = false;
//               });
//               if (widget.onLeadingIconPress != null) {
//                 widget.onLeadingIconPress();
//               }
//               AppTheme.deductedHeight = 0.4;
//               AppTheme.deductedWidth = 0.2;
//             } else {
//               setState(() {
//                 isCollapsed = true;
//               });
//               AppTheme.deductedHeight = 0.0;
//               AppTheme.deductedWidth = 0.0;
//             }
//             if (widget.onLeadingIconPress != null) {
//               widget.onLeadingIconPress();
//             }
//             //_scaffoldKey.currentState.openDrawer();
//           });
//         }
//         list.add(
//           Expanded(
//             flex: 1,
//             child: RotatedBox(
//               quarterTurns: 4,
//               child: leadIcon,
//             ),
//           ),
//         );
//       } else {
//         list.add(Expanded(flex: 1, child: Text('')));
//       }
//       if (widget.defaultAppBar || widget.showSearchBar) {
//         list.add(
//           Expanded(
//             flex: 7,
//             child: _search(),
//           ),
//         );
//       } else {
//         list.add(Expanded(flex: 7, child: Text('')));
//       }
//       if (widget.defaultAppBar || widget.actionIcon != null) {
//         var actionIcon;
//         if (widget.actionIcon != null) {
//           actionIcon =
//               _icon(widget.actionIcon, color: LightColor.orange, onPressed: () {
//             if (widget.onActionIconPress != null) {
//               widget.onActionIconPress();
//             }
//           });
//         } else {
//           actionIcon = _icon(Icons.shopping_cart,
//               color: Colors.white,
//               size: 28,
//               backgroundColor: LightColor.orange, onPressed: () {
//             _scaffoldKey.currentContext.addEvent(CartItemsViewEvent());
//           });
//         }
//         list.add(
//           Expanded(
//             flex: 1,
//             child: RotatedBox(
//               quarterTurns: 4,
//               child: actionIcon,
//             ),
//           ),
//         );
//       } else {
//         list.add(Expanded(flex: 1, child: Text('')));
//       }
//     }
//     return Container(
//       padding: isSearchFocused ? AppTheme.padding : AppTheme.padding,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: list,
//       ),
//     );
//   }

//   Widget _icon(IconData icon,
//       {Color color = LightColor.iconColor,
//       Color backgroundColor,
//       double size,
//       void Function() onPressed}) {
//     backgroundColor = backgroundColor ?? Theme.of(context).backgroundColor;
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         padding: EdgeInsets.only(left: 6, right: 8, top: 6, bottom: 6),
//         decoration: BoxDecoration(
//             borderRadius: LayoutConstants.borderRadius,
//             color: backgroundColor,
//             boxShadow: AppTheme.shadow),
//         child: size == null
//             ? Icon(icon, color: color)
//             : Icon(icon, color: color, size: size),
//       ),
//     );
//   }

//   Widget _search() {
//     return Container(
//       margin: AppTheme.padding,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               height: isSearchFocused ? 50 : 40,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: LightColor.lightGrey.withAlpha(100),
//                   borderRadius: LayoutConstants.borderRadius),
//               child: TextField(
//                 focusNode: _searchFocusNode,
//                 //controller: TextEditingController(text: widget.searchQuery),
//                 style: isSearchFocused ? TextConstants.P4 : TextConstants.P5,
//                 onSubmitted: (value) {
//                   _scaffoldKey.currentContext
//                       .addEvent(SearchEvent(widget.searchQuery));
//                 },
//                 onChanged: (String query) {
//                   setState(() {
//                     if (widget.searchQuery == null) {
//                       widget.searchQuery = "";
//                     }
//                     widget.searchQuery = query;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "Search Products",
//                   hintStyle:
//                       isSearchFocused ? TextConstants.P4 : TextConstants.P5,
//                   contentPadding: EdgeInsets.only(
//                     left: 10,
//                     right: 10,
//                     bottom: 10,
//                     top: 5,
//                   ),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.black54,
//                     size: isSearchFocused
//                         ? TextConstants.P4.fontSize
//                         : TextConstants.P5.fontSize,
//                   ),
//                   suffix: isSearchFocused &&
//                           widget.searchQuery != null &&
//                           widget.searchQuery.isNotEmpty
//                       ? InkWell(
//                           onTap: () => {
//                                 _scaffoldKey.currentContext
//                                     .addEvent(SearchEvent(widget.searchQuery))
//                               },
//                           child: Icon(
//                             Icons.arrow_forward,
//                             color: Colors.black54,
//                             size: isSearchFocused
//                                 ? TextConstants.P4.fontSize
//                                 : TextConstants.P5.fontSize,
//                           ))
//                       : null,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _searchWidget() {
//     return Center(
//       child: Text(
//         "Cool !!!",
//         style: TextConstants.H2,
//       ),
//     );
//   }

//   void onBottomIconPressed(int index) {
//     if (index == 0 || index == 1) {
//       setState(() {
//         isHomePageSelected = true;
//       });
//     } else {
//       setState(() {
//         isHomePageSelected = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget childBody;
//     if (widget.onRefresh == null) {
//       childBody = widget.body;
//     } else {
//       childBody = RefreshIndicator(
//         child: widget.body,
//         onRefresh: widget.onRefresh,
//       );
//     }

//     var body = SingleChildScrollView(
//       child: Container(
//         height: AppTheme.fullHeight(context) - (widget.showBottomNav ? 50 : 0),
//         decoration: BoxDecoration(
//           // borderRadius: BorderRadius.all(Radius.circular(10)),
//           gradient: LinearGradient(
//             colors: [
//               Color(0xfffbfbfb),
//               Color(0xfff7f7f7),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             _appBar(),
//             Expanded(
//               child: AnimatedSwitcher(
//                 duration: Duration(milliseconds: 300),
//                 switchInCurve: Curves.easeInToLinear,
//                 switchOutCurve: Curves.easeOutBack,
//                 child: childBody,
//               ),
//             )
//           ],
//         ),
//       ),
//     );

//     var list = List<Widget>();
//     if (!isCollapsed) {}

//     list.add(body);
//     if (widget.showBottomNav == true) {
//       var bottomNav = Positioned(
//         bottom: 0,
//         right: 0,
//         child: widget.bottomBar == null
//             ? CustomBottomNavigationBar(
//                 onIconPressedCallback: onBottomIconPressed,
//               )
//             : widget.bottomBar,
//       );
//       list.add(bottomNav);
//     }
//     Size size = MediaQuery.of(context).size;
//     screenWidth = size.width;
//     screenHeight = size.height;

//     //return
//     var mainBody = AnimatedPositioned(
//       duration: duration,
//       top: isCollapsed ? 0 : 0.2 * screenHeight,
//       bottom: isCollapsed ? 0 : 0.2 * screenWidth,
//       left: isCollapsed ? 0 : 0.6 * screenWidth,
//       right: isCollapsed ? 0 : -0.4 * screenWidth,
//       child: Material(
//         borderRadius: isCollapsed
//             ? BorderRadius.zero
//             : BorderRadius.all(Radius.circular(10)),
//         elevation: 8,
//         color: Color(0xfffbfbfb),
//         child: InkWell(
//           child: SafeArea(
//             child: Stack(
//               fit: StackFit.expand,
//               children: list,
//             ),
//           ),
//           onTap: () {},
//         ),
//       ),
//     );
//     var mainStack = List<Widget>();
//     if (widget.activateDrawer) {
//       mainStack.add(AppBackground());
//       //  mainStack.add(AppDrawer());
//     }
//     mainStack.add(mainBody);
//     return Scaffold(
//       key: _scaffoldKey,
//       resizeToAvoidBottomPadding: false,
//       floatingActionButton: widget.floatingActionButton,
//       backgroundColor: Colors.white.withOpacity(0.9),
//       //drawer: Drawer(child: AppDrawer()),
//       body: Stack(
//         children: mainStack,
//       ),
//     );
//   }

//   Widget _getMenu() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text('My Profile'),
//           LayoutConstants.sizedBox5H,
//           Text('My Wishlist'),
//           LayoutConstants.sizedBox5H,
//           Text('My Orders'),
//           LayoutConstants.sizedBox5H,
//           Text('My Cart'),
//           LayoutConstants.sizedBox5H,
//           Text('My Settings'),
//           LayoutConstants.sizedBox5H
//         ],
//       ),
//     );
//   }
// }
