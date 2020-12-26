import 'package:bluebellapp/models/category_dto.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:flutter/material.dart';

class ServiceCompactView extends StatelessWidget {
  final CategoryDto categoryDto;
  const ServiceCompactView({Key key, this.categoryDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: ServiceCompactViewCard(
        categoryDto: categoryDto,
      ),
    );
  }
}

class ServiceCompactViewCard extends StatelessWidget {
  final CategoryDto categoryDto;
  const ServiceCompactViewCard({
    this.categoryDto,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: LayoutConstants.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              ApiRoutes.CdnPath + categoryDto.pictureThumbPath,
              color: Color(0XFFEA7623),
              height: 80,
              width: 70,
            ),
          ),
          Text(
            categoryDto.name,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
