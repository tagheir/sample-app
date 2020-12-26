// import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
// import 'package:bluebellapp/models/category_dto.dart';
// import 'package:bluebellapp/models/homeViewModel.dart';
// import 'package:bluebellapp/models/product_dto.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/left_text_fz20_w7.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/loading_indicator.dart';
// import 'package:bluebellapp/screens/widgets/views_widgets/package_compact_view_widget.dart';
// import 'package:bluebellapp/screens/widgets/views_widgets/product_compact_view.dart';
// import 'package:bluebellapp/screens/widgets/views_widgets/service_compact_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeScreen extends StatefulWidget {
//   final Function call;
//   final HomePageViewModel homePageViewModel;
//   const HomeScreen({this.call, Key key, this.homePageViewModel})
//       : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   BuildContext _context;

//   @override
//   Widget build(BuildContext context) {
//     _context = context;
//     //////print(homePageViewModel);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: widget.homePageViewModel == null
//               ? LoadingIndicator()
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     getCategoryLabel('Packages', 0),
//                     widget.homePageViewModel.packages != null
//                         ? getPackagesList(
//                             packages: widget.homePageViewModel.packages)
//                         : Text(""),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     getCategoryLabel('Facilities Management Services', 1),
//                     widget.homePageViewModel.facilitiesManagementServices !=
//                             null
//                         ? getServicesList(
//                             category: widget.homePageViewModel
//                                 .facilitiesManagementServices.subCategories)
//                         : Text(""),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     getCategoryLabel('Landscape Services', 3),
//                     widget.homePageViewModel.landscapeServices != null
//                         ? getServicesList(
//                             category: widget.homePageViewModel.landscapeServices
//                                 .subCategories)
//                         : Text(""),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     getCategoryLabel('Products', 4),
//                     widget.homePageViewModel.products != null
//                         ? getProductsList(
//                             widget.homePageViewModel.products.products)
//                         : Text('')
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }

//   getProductsList(List<ProductDto> products) {

//     return products == null || products?.length == 0
//         ? DataEmpty(message: 'No products to show')
//         : Container(
//             // color: Colors.red,
//             height: 150.0,
//             // color: Colors.yellow,
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: products?.length,
//                 itemBuilder: (ctx, idx) {
//                   //  var item = category.subCategories[idx];
//                   return ProductCompactView(
//                     product: products[idx],
//                   );
//                 }),
//           );
//   }

//   getServicesList({List<CategoryDto> category}) {
//     return category == null || category?.length == 0
//         ? DataEmpty(
//             message: 'No services to show',
//           )
//         : Container(
//             // color: Colors.red,
//             height: 150.0,
//             // color: Colors.yellow,
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: category.length,
//                 itemBuilder: (ctx, idx) {
//                   var item = category[idx];
//                   return GestureDetector(
//                       onTap: () {
//                         BlocProvider.of<AppBloc>(_context).add(
//                             CategoryProductsViewEvent(
//                                 products: category[idx].products));
//                       },
//                       child: ServiceCompactView(
//                         categoryDto: item,
//                       ));
//                 }),
//           );
//   }

//   Container getPackagesList({List<ProductDto> packages}) {
//     return Container(
//       height: 180.0,
//       child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: packages.length,
//           itemBuilder: (ctx, idx) {
//             var item = packages[idx];
//             return PackageCompactViewWidget(
//               product: item,
//             );
//           }),
//     );
//   }

//   Row getCategoryLabel(String label, int index) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         LeftTextFz20Fw7(label),
//         FlatButton(
//           onPressed: () {},
//           child: FlatButton(
//             onPressed: () {
//               widget.call(index);
//             },
//             child: Text(
//               'View All',
//               style: TextStyle(color: Color(0xFFEA7623)),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
