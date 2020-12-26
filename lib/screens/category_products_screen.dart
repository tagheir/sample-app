// import 'package:bluebellapp/models/product_dto.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
// import 'package:bluebellapp/resources/themes/theme.dart';
// import 'package:bluebellapp/screens/shared/_layout_screen.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
// import 'package:bluebellapp/screens/widgets/views_widgets/product_compact_view.dart';
// import 'package:bluebellapp/services/category_service.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
// import 'package:flutter/material.dart';

// class CategoryProductsScreen extends StatelessWidget {
//   final List<ProductDto> products;
//   final String title;
//   CategoryProductsScreen({this.products, this.title});
//   var availablwWidth;
//   int rowCount = 0;
//   @override
//   Widget build(BuildContext context) {
//     if (MediaQuery.of(context).orientation == Orientation.landscape) {
//       rowCount = 3;
//     } else {
//       rowCount = 2;
//     }
//     availablwWidth = (AppTheme.fullWidth(context) - 32) / rowCount;
//     var body = List<Widget>();
//     body.add(_title());
//     body.add(products == null || products?.length == 0
//         ? DataEmpty(message: 'No products to show')
//         : Flexible(
//             child: ListView(
//               children: <Widget>[getProducts()],
//             ),
//           ));
//     return LayoutScreenOld(
//       showDefaultBackButton: true,
//       showBottomNav: false,
//       body: Column(children: body),
//     );
//   }

//   getProducts() {
//     var list = products.asMap().entries.map((entry) {
//       int idx = entry.key;
//       var prod = entry.value;
//       return Expanded(
//         flex: 1,
//         child: Container(
//           child: ProductCompactView(
//             product: prod,
//             height: getCardHeight(idx, rowCount, products, availablwWidth),
//           ),
//         ),
//       );
//     }).toList();
//     return Column(
//       children: getGridRowsList(rowCount, list, availablwWidth),
//     ).padding(EdgeInsets.all(8));
//   }

//   Widget _title() {
//     return Container(
//       margin: AppTheme.padding,
//       alignment: Alignment.topLeft,
//       child: Text(title ?? 'Categories', style: TextConstants.H5),
//     );
//   }
// }
