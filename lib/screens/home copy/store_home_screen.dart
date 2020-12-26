// import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
// import 'package:bluebellapp/models/storeHomeViewModel.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
// import 'package:bluebellapp/repos/services_repo.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/responsive_constants.dart';
// import 'package:bluebellapp/services/category_service.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
// import 'package:bluebellapp/resources/theme_scheme.dart';
// import 'package:bluebellapp/resources/themes/theme.dart';
// import 'package:bluebellapp/screens/shared/_layout_screen.dart';
// import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
// import 'package:bluebellapp/screens/widgets/loading_indicator.dart';
// import 'package:bluebellapp/screens/widgets/views_widgets/product_compact_view.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import '../facilities_management_services_grid_screen.dart';

// class StoreHomeScreen extends StatefulWidget {
//   @override
//   _StoreHomeScreenState createState() => _StoreHomeScreenState();
// }

// class _StoreHomeScreenState extends State<StoreHomeScreen> {
//   bool isDataLoaded = false;
//   bool isDataLoadedFailure = false;
//   bool isDataLoadingInProgress = false;
//   static StoreHomePageViewModel storeHomePageViewModel;
//   ServiceRepository serviceRepo;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int _current = 0;
//   var availableWidth;
//   int rowCount = ResponsiveConstants.gridRowCount;

//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text(value),
//     ));
//   }

//   getStoreHomeData({
//     bool forceNetwork = false,
//   }) {
//     getStoreHomeDataFuture(forceNetwork: forceNetwork)
//         .then((a) => {////print("CallBack")});
//   }

//   Future<void> getStoreHomeDataFuture({
//     bool forceNetwork = false,
//   }) async {
//     if (isDataLoadingInProgress == true) {
//       return Future.value();
//     }
//     isDataLoadedFailure = false;
//     var data = await serviceRepo.getStoreHomeData(
//       forceNetwork: forceNetwork,
//       callback: (data) {
//         if (data != null) {
//           setState(() {
//             isDataLoaded = true;
//             isDataLoadedFailure = false;
//             if (storeHomePageViewModel == null) {
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
//         if (storeHomePageViewModel == null || data != null) {
//           storeHomePageViewModel = data;
//         }
//       });
//     }
//   }

//   Widget getFeaturedCategories() {
//     var list =
//         storeHomePageViewModel.featuredCategories.asMap().entries.map((entry) {
//       int idx = entry.key;
//       var cat = entry.value;
//       return Expanded(
//         flex: 1,
//         child: Container(
//           height: getCardHeight(idx, rowCount,
//               storeHomePageViewModel.featuredCategories, availableWidth),
//           child: CategoryCard(cat),
//         ),
//       );
//     }).toList();
//     return Column(children: getGridRowsList(rowCount, list, availableWidth))
//         .padding(EdgeInsets.all(8));
//   }

//   Widget getFeaturedProducts() {
//     var list = storeHomePageViewModel.promotedFeaturedProducts
//         .asMap()
//         .entries
//         .map((entry) {
//       int idx = entry.key;
//       var prod = entry.value;
//       return Expanded(
//         flex: 1,
//         child: Container(
//           child: ProductCompactView(
//             product: prod,
//             height: getCardHeight(
//                 idx,
//                 rowCount,
//                 storeHomePageViewModel.promotedFeaturedProducts,
//                 availableWidth),
//           ),
//         ),
//       );
//     }).toList();
//     return Column(
//       children: getGridRowsList(rowCount, list, availableWidth),
//     ).padding(EdgeInsets.all(8));
//   }

//   Widget getPromotedFeaturedProducts() {
//     if (storeHomePageViewModel.promotedFeaturedProducts == null) return null;
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: <Widget>[
//           Container(
//             child: Text('Promoted Products',
//                     style: TextConstants.H6
//                         .apply(color: ThemeScheme.lightTheme.primaryColor))
//                 .padding(EdgeInsets.all(8.0)),
//           ),
//           Container(
//             height: getMaxCardHeight(
//                 storeHomePageViewModel.promotedFeaturedProducts
//                     .map((value) => value.name)
//                     .toList(),
//                 availableWidth,
//                 rowCount),
//             color: Colors.white,
//             width: double.infinity,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               children: storeHomePageViewModel.promotedFeaturedProducts
//                   .map((product) => Container(
//                       width: availableWidth,
//                       child: ProductCompactView(
//                         product: product,
//                         height: getMaxCardHeight(
//                             storeHomePageViewModel.promotedFeaturedProducts
//                                 .map((value) => value.name)
//                                 .toList(),
//                             availableWidth,
//                             rowCount),
//                       )))
//                   .toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _subTitle(String title, Function onTap) {
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
//           GestureDetector(
//             onTap: () {
//               onTap();
//             },
//             child: Icon(
//               Icons.navigate_next,
//               color: ThemeScheme.lightTheme.primaryColor,
//               size: 40,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   List<Widget> getImageSliders() {
//     if (storeHomePageViewModel?.banners != null) {
//       List<Widget> imageSliders = storeHomePageViewModel.banners
//           .map((item) => Container(
//                 child: Container(
//                   child: ClipRRect(
//                       borderRadius: LayoutConstants.borderRadius,
//                       child: Stack(
//                         children: <Widget>[
//                           ContainerCacheImage(
//                             altImageUrl: "https://placehold.it/600",
//                             imageUrl: item?.bannerPath,
//                             borderRadius: LayoutConstants.borderRadius,
//                             width: 500,
//                             height: 200,
//                             fit: BoxFit.fill,
//                           )

//                           // Positioned(
//                           //   bottom: 15.0,
//                           //   left: 0.0,
//                           //   right: 0.0,
//                           //   child: Row(
//                           //     mainAxisAlignment: MainAxisAlignment.center,
//                           //     children:
//                           //         storeHomePageViewModel.banners.map((banner) {
//                           //       int index = storeHomePageViewModel.banners
//                           //           .indexOf(banner);
//                           //       return Container(
//                           //         width: 8.0,
//                           //         height: 8.0,
//                           //         margin: EdgeInsets.symmetric(
//                           //             vertical: 10.0, horizontal: 2.0),
//                           //         decoration: BoxDecoration(
//                           //           shape: BoxShape.circle,
//                           //           color: _current == index
//                           //               ? Color.fromRGBO(0, 0, 0, 0.9)
//                           //               : Color.fromRGBO(0, 0, 0, 0.4),
//                           //         ),
//                           //       );
//                           //     }).toList(),
//                           //   ),
//                           // ),
//                         ],
//                       )),
//                 ),
//               ))
//           .toList();
//       return imageSliders;
//     }
//     return List<Widget>();
//   }

//   Widget getSliderWidget() {
//     return Column(children: [
//       CarouselSlider(
//         items: getImageSliders(),
//         options: CarouselOptions(
//             autoPlay: true,
//             enlargeCenterPage: true,
//             aspectRatio: 2.0,
//             onPageChanged: (index, reason) {
//               // setState(() {
//               //    _current = index;
//               // });
//             }),
//       ),
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     serviceRepo = serviceRepo ?? context.getRepo().getServiceRepository();
//     if (MediaQuery.of(context).orientation == Orientation.landscape) {
//       rowCount = 4;
//     } else {
//       rowCount = 3;
//     }
//     availableWidth = (AppTheme.fullWidth(context) - 32) / rowCount;
//     if (storeHomePageViewModel == null && isDataLoaded == false) {
//       getStoreHomeData();
//     } else {
//       setState(() {
//         isDataLoaded = true;
//       });
//     }
//     var body = List<Widget>();
//     if (isDataLoaded == false) {
//       body.add(LoadingIndicator());
//     } else {
//       body.add(getSliderWidget());
//       if (storeHomePageViewModel?.promotedFeaturedProducts != null) {
//         body.add(LayoutConstants.sizedBox10H);
//         body.add(getPromotedFeaturedProducts());
//       }
//       if (storeHomePageViewModel?.featuredProducts != null) {
//         body.add(LayoutConstants.sizedBox10H);
//         body.add(_subTitle('Featured Products', () {
//           context.addEvent(
//             CategoryProductsViewEvent(
//               products: storeHomePageViewModel?.featuredProducts,
//             ),
//           );
//         }));
//         body.add(LayoutConstants.sizedBox10H);
//         body.add(getFeaturedProducts());
//       }

//       if (storeHomePageViewModel?.featuredCategories != null) {
//         body.add(LayoutConstants.sizedBox10H);
//         body.add(_subTitle('Featured Categories', () {
//           context.addEvent(
//             SubCategoryViewEvent(
//               subCategories: storeHomePageViewModel?.featuredCategories,
//             ),
//           );
//         }));
//         body.add(LayoutConstants.sizedBox10H);
//         body.add(getFeaturedCategories());
//       }
//     }
//     body.add(LayoutConstants.sizedBox20H);
//     return LayoutScreenOld(
//       scaffoldKey: _scaffoldKey,
//       showBottomNav: false,
//       onRefresh: () async {
//         return getStoreHomeDataFuture(forceNetwork: true);
//       },
//       onLeadingIconPress: () {
//         setState(() {
//           availableWidth = AppTheme.fullWidth(context);
//         });
//       },
//       body: Container(
//         child: ListView(
//           children: body,
//         ),
//       ),
//     );
//   }
// }
