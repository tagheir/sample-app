import 'package:bluebellapp/models/category_dto.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/facility_widget.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/landscape_widget.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/product_widget.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  final CategoryDto category;
  CategoryView({this.category});
  @override
  Widget build(BuildContext context) {
    if (category.templateTypeName == 'landScape') {
      return LandScapeWidget(category: this.category);
    } else if (category.templateTypeName == 'facilityManagement') {
      return FacilityWidget(
        category: this.category,
      );
    } else if (category.templateTypeName == 'product') {
      return ProductWidget(
        category: this.category,
      );
    }
    return Text('Template Name Not Found');
  }
}
