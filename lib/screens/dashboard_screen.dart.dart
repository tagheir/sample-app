// import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
// import 'package:bluebellapp/models/homeViewModel.dart';
// import 'package:bluebellapp/resources/theme_scheme.dart';
// import 'package:bluebellapp/screens/packages_screen.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/loading_indicator.dart';
// import 'package:bluebellapp/screens/widgets/views_widgets/drawer.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'catalog/products_grid.dart';
// import 'facilities_management_services_grid_screen.dart';
// import 'home_screen.dart';
// import 'landscape_services_grid_screen.dart';
// import 'widgets/helper_widgets/button_widgets/btn_simple_btn.dart';

// class DashboardScreen extends StatefulWidget {
//   DashboardScreen({Key key}) : super(key: key);
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _page = 2;
//   HomePageViewModel homePageViewModel;

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool isDataLoaded = false;
//   var serviceRepo;
//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text(value),
//     ));
//   }

//   setTab(int page) {
//     setState(() {
//       _page = page;
//     });
//   }
//   Widget getRetryButton(){
//     return SimpleButton(text: 'RETRY',onPressed: (){
//         setState(() {
//           isDataLoaded = false;
//         });
//     });
//   }
//   getDashBoardData(){
//     serviceRepo.getHomeData(callback: (data) {
//         setState(() {
//           isDataLoaded = true;
//         });
//         showInSnackBar(data);
//       }).then((data) {
//         setState(() {
//           //  ////print("==================data==================");
//           isDataLoaded = true;
//           homePageViewModel = data;
//           //  ////print(homePageViewModel.packages.length);
//         });
//       });
//   }
//   @override
//   Widget build(BuildContext context) {
//      serviceRepo =
//         context.getAppBloc().getRepo().getServiceRepository();
//     if (homePageViewModel == null && isDataLoaded == false) {
//       getDashBoardData();
//     }
//     Widget packages = LoadingIndicator();
//     Widget facilitiesManagement = LoadingIndicator();
//     Widget home = LoadingIndicator();
//     Widget landscape = LoadingIndicator();
//     Widget products = LoadingIndicator();

//     if (isDataLoaded && homePageViewModel != null) {
//       packages = PackagesScreen(packages: homePageViewModel?.packages);
//       facilitiesManagement = FacilitiesManagementServicesGrid(
//           categories:
//               homePageViewModel?.facilitiesManagementServices?.subCategories);
//       home = HomeScreen(
//         homePageViewModel: homePageViewModel,
//         call: (value) {
//           setState(() {
//             _page = value;
//             ////print(_page.toString());
//           });
//         },
//       );
//       landscape = LandscapeServicesGrid(
//           categories: homePageViewModel?.landscapeServices?.subCategories);
//       //  landscape = LandscapeServicesGrid(
//       //     categories: homePageViewModel?.landscapeServices?.subCategories);
//       products =
//           ProductsGrid(categories: homePageViewModel?.products?.subCategories);
//     } else if (isDataLoaded && homePageViewModel == null) {
//       home = getRetryButton();
//       facilitiesManagement = getRetryButton();
//       landscape = getRetryButton();
//       products = getRetryButton();
//       packages = getRetryButton();
//       //RETRY BUTTON
//     }

//     //***my code****//
//     List<Widget> screenDisplay = [
//       // Packages
//       packages,

//       // Facility Management
//       facilitiesManagement,

//       // Home Screen
//       home,

//       // Landscape services
//       landscape,

//       // Products
//       products,

//       //ProductsGrid(categories: homePageViewModel.products.subCategories,),
//       // categories: homePageViewModel.landscapeServices.subCategories,
//     ];

//     //*****************App Bar***************//
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: Drawer(child: AppDrawer()),
//       appBar: AppBar(
//         backgroundColor: ThemeScheme.iconColorDrawer,
//         title: Text('bluebell', style: TextStyle(color: Colors.white)),
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: <Widget>[
//           IconButton(
//               icon:
//                   Icon(Icons.add_shopping_cart, color: Colors.white, size: 30),
//               onPressed: () {
//                 context.addEvent(CartItemsViewEvent());
//               }),
//         ],
//       ),

//       // body: HomeWidget(),
//       body: screenDisplay[_page],

//       //***********Bottom Navigation Bar**************//

//       bottomNavigationBar: CurvedNavigationBar(
//         height: 55.0,
//         index: _page,
//         color: ThemeScheme.lightTheme.primaryColor,
//         backgroundColor: Colors.white,
//         items: <Widget>[
//           Icon(
//             Icons.search,
//             size: 30.0,
//             color: ThemeScheme.iconColorNavBar,
//           ),
//           Icon(
//             Icons.sentiment_dissatisfied,
//             size: 30.0,
//             color: ThemeScheme.iconColorNavBar,
//           ),
//           Icon(Icons.home, size: 40.0, color: ThemeScheme.iconColorNavBar),
//           Icon(Icons.sentiment_very_satisfied,
//               size: 40.0, color: ThemeScheme.iconColorNavBar),
//           Icon(Icons.exit_to_app,
//               size: 40.0, color: ThemeScheme.iconColorNavBar),
//         ],
//         animationDuration: Duration(milliseconds: 600),
//         animationCurve: Curves.easeInOutCirc,
//         onTap: (index) {
//           setState(() {
//             _page = index;
//           });
//         },
//       ),
//     );
//   }
// }
