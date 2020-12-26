// import 'package:bluebellapp/models/homeViewModel.dart';
// import 'package:bluebellapp/repos/services_repo.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
// import 'package:bluebellapp/resources/themes/theme.dart';
// import 'package:bluebellapp/screens/catalog/maintenance_package_compact_view.dart';
// import 'package:bluebellapp/screens/facilities_management_services_grid_screen.dart';
// import 'package:bluebellapp/screens/shared/_layout_screen.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/button_widgets/btn_simple_btn.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/loading_indicator.dart';
// import 'package:flutter/material.dart';

// class ServicesHomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<ServicesHomeScreen> {
//   bool isDataLoaded = false;
//   bool isDataLoadedFailure = false;
//   bool isDataLoadingInProgress = false;
//   HomePageViewModel homePageViewModel;
//   ServiceRepository serviceRepo;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   Size size;

//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text(value),
//     ));
//   }

//   Widget getRetryButton() {
//     return SimpleButton(
//         text: 'RETRY',
//         onPressed: () {
//           setState(() {
//             isDataLoaded = false;
//           });
//         });
//   }

//   getDashBoardData({
//     bool forceNetwork = false,
//   }) {
//     getDashBoardDataFuture(forceNetwork: forceNetwork)
//         .then((a) => {////print("CallBack")});
//   }

//   Future<void> getDashBoardDataFuture({
//     bool forceNetwork = false,
//   }) async {
//     if (isDataLoadingInProgress == true) {
//       return Future.value();
//     }
//     isDataLoadedFailure = false;
//     var data = await serviceRepo.getHomeData(
//       forceNetwork: forceNetwork,
//       callback: (data) {
//         if (data != null) {
//           setState(() {
//             isDataLoaded = true;
//             isDataLoadedFailure = false;
//             if (homePageViewModel == null) {
//               isDataLoadedFailure = true;
//             }
//           });
//         }
//         showInSnackBar(data);
//       },
//     );
//     if (data != null) {
//       setState(() {
//         isDataLoaded = true;
//         isDataLoadedFailure = false;
//         if (homePageViewModel == null || data != null) {
//           homePageViewModel = data;
//         }
//       });
//     }
//   }

//   Widget _horizontalListWidget(List<Widget> widgets, {double height = 170}) {
//     //////print(widgets);
//     return Container(
//       margin: AppTheme.padding,
//       width: AppTheme.fullWidth(context),
//       height: height,
//       child: ListView(scrollDirection: Axis.horizontal, children: widgets),
//     );
//   }

//   Widget _title() {
//     return Container(
//       margin: AppTheme.padding,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text('How can we help you today?', style: TextConstants.H6_5),
//             ],
//           ),
//           Spacer(),
//         ],
//       ),
//     );
//   }

//   Widget _subTitle(String title) {
//     return Container(
//       margin: AppTheme.h2Padding,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(title, style: TextConstants.H5),
//             ],
//           ),
//           Spacer(),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     serviceRepo = serviceRepo ?? context.getRepo().getServiceRepository();
//     size = MediaQuery.of(context).size;
//     if (homePageViewModel == null && isDataLoaded == false) {
//       getDashBoardData();
//     }
//     var body = List<Widget>();
//     body.add(_title());
//     if (isDataLoaded == false) {
//       body.add(LoadingIndicator());
//     } else {
//       var facilitiesManagement = getFacilitiesManagementServicesSlider();
//       if (facilitiesManagement != null) {
//         body.add(_subTitle('Facilities Management Services'));
//         body.add(facilitiesManagement);
//         body.add(LayoutConstants.sizedBox15H);
//       }

//       var packages = getMaintenancePackagesSlider();
//       if (packages != null) {
//         body.add(_subTitle('Maintenance Packages'));
//         body.add(packages);
//         body.add(LayoutConstants.sizedBox35H);
//       }
//     }
//     //var fun = () => getDashBoardData(forceNetwork: true);
//     return LayoutScreenOld(
//       scaffoldKey: _scaffoldKey,
//       showBottomNav: false,
//       onRefresh: () async {
//         return getDashBoardDataFuture(forceNetwork: true);
//       },
//       body: Container(
//         child: ListView(
//           children: body,
//         ),
//       ),
//     );
//   }

//   Widget getFacilitiesManagementServicesSlider() {
//     var facilitiesManagement =
//         homePageViewModel?.facilitiesManagementServices?.subCategories;
//     if (facilitiesManagement == null) return null;
//     return _horizontalListWidget(
//       facilitiesManagement.map(
//         (service) {
//           //////print(service.picturePath);
//           return Container(child: CategoryCard(service));
//         },
//       ).toList(),
//     );
//   }

//   Widget getMaintenancePackagesSlider() {
//     var packages = homePageViewModel?.packages;
//     //////print("Packages Status => " + (packages?.length ?? 0).toString());
//     if (packages == null) return null;
//     return _horizontalListWidget(
//       packages.map(MaintenancePackageCompactView.transform).toList(),
//       height: 220,
//     );
//   }
// }
