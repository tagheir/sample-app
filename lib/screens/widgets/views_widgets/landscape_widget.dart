import 'package:bluebellapp/models/category_dto.dart';
import 'package:bluebellapp/screens/widgets/views_widgets/service_compact_view.dart';
import 'package:flutter/material.dart';

class LandScapeWidget extends StatelessWidget {
  final CategoryDto category;
  LandScapeWidget({this.category});
  @override
  Widget build(BuildContext context) {
    return ServiceCompactView(categoryDto: category,);
  }
}