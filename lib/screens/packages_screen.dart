import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/screens/catalog/maintenance_package_compact_view.dart';
import 'package:bluebellapp/screens/widgets/helper_widgets/empty_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_svg/svg.dart';

class PackagesScreen extends StatelessWidget {
  final List<ProductDto> packages;
  PackagesScreen({this.packages});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: packages?.length == 0
              ? DataEmpty(
                  message: 'No packages to show',
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: List.generate(packages.length, (index) {
                      return MaintenancePackageCompactView(
                        product: packages[index],
                      );
                    }),
                  ),
                ),
        ),
      ),
    );
  }
}
