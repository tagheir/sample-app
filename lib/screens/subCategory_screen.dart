// import 'package:bluebellapp/models/category_dto.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
// import 'package:bluebellapp/resources/themes/theme.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
// import 'package:bluebellapp/screens/shared/_layout_screen.dart';
// import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
// import 'package:bluebellapp/screens/facilities_management_services_grid_screen.dart';
// import 'package:bluebellapp/services/category_service.dart';
// import 'package:flutter/material.dart';

// class SubCategoryScreen extends StatelessWidget {
//   final List<CategoryDto> categories;
//   final String title;
//   SubCategoryScreen({this.categories, this.title});
//   double avaliabelWidth;
//   int rowCount = 0;
//   @override
//   Widget build(BuildContext context) {
//     if (MediaQuery.of(context).orientation == Orientation.landscape) {
//       rowCount = 3;
//     } else {
//       rowCount = 2;
//     }
//     avaliabelWidth = (AppTheme.fullWidth(context) - 32) / rowCount;
//     var body = List<Widget>();
//     body.add(_title());
//     body.add(categories == null || categories?.length == 0
//         ? DataEmpty(message: 'No products to show')
//         : Flexible(
//             child: ListView(
//               children: <Widget>[getCategories(context)],
//             ),
//           ));
//     return LayoutScreenOld(
//       showDefaultBackButton: true,
//       showBottomNav: false,
//       body: Column(children: body),
//     );
//   }

//   getCategories(BuildContext cntxt) {
//     var list = categories.asMap().entries.map((entry) {
//       int idx = entry.key;
//       var cat = entry.value;
//       return Expanded(
//         flex: 1,
//         child: Container(
//           height: getCardHeight(idx, rowCount, categories, avaliabelWidth),
//           child: CategoryCard(cat),
//         ),
//       );
//     }).toList();
//     return Column(children: getGridRowsList(rowCount, list, avaliabelWidth))
//         .padding(EdgeInsets.all(8));
//   }

//   Widget _title() {
//     return Container(
//       margin: AppTheme.padding,
//       alignment: Alignment.topLeft,
//       child: Text(title ?? 'Categories', style: TextConstants.H5),
//     );
//   }
// }
