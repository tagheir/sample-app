import 'package:bluebellapp/models/category_info_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/network_cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final CategoryInfoDto category;
  final double availableWidth;
  final double availableHeight;
  final Function onTap;
  CategoryCard(this.category,
      {this.availableWidth, this.availableHeight, this.onTap});

  @override
  Widget build(BuildContext context) {
    var color = LightColor.grey;
    // if (category.templateType == TemplateType.FacilitiesManagement) {
    //   color = LightColor.orange;
    // } else if (category.templateType == TemplateType.Landscape) {
    //   color = LightColor.green;
    // } else if (category.templateType == TemplateType.MaintenancePackage) {
    //   color = LightColor.lightGrey;
    // } else if (category.templateType == TemplateType.Default) {
    //   color = LightColor.darkGrey;
    // }
    return ServiceCategoryCard(
      category: category,
      availableWidth: availableWidth,
      availableHeight: availableHeight,
      onTap: this.onTap,
    );
  }
}

class StoreCategoryCard extends StatelessWidget {
  const StoreCategoryCard(
      {Key key, this.category, this.availableWidth, this.availableHeight})
      : super(key: key);

  final CategoryInfoDto category;
  final double availableWidth;
  final double availableHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // category.subCategories.length > 0
        //     ? context.addEvent(
        //         SubCategoryViewEvent(
        //           subCategories: category.subCategories,
        //           category: category,
        //         ),
        //       )
        //     : category.products.length > 0
        //         ? context.addEvent(CategoryProductsViewEvent(
        //             products: category.products,
        //             category: category,
        //           ))
        //         : Text('');
      },
      child: Container(
        margin: AppTheme.h_5Padding,
        width: double.infinity,
        height: availableWidth,
        decoration: LayoutConstants.boxDecoration,
        child: Column(
          children: <Widget>[
            Container(
              height: availableWidth * 0.7,
              width: double.infinity,
              child: ClipRRect(
                child: NetworkCacheImage(
                  altImageUrl: "https://placehold.it/130",
                  fit: BoxFit.fill,
                  imageUrl: category.bannerUrl,
                ),
              ),
            ),
            Text(
              category.title,
              textAlign: TextAlign.center,
              style: TextConstants.H7,
            )
          ],
        ),
      ),
    );
  }
}

class ServiceCategoryCard extends StatelessWidget {
  const ServiceCategoryCard(
      {Key key,
      this.category,
      this.availableWidth,
      this.availableHeight,
      this.onTap})
      : super(key: key);

  final CategoryInfoDto category;
  final double availableWidth;
  final double availableHeight;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: Container(
        margin: AppTheme.h_5Padding,
        width: availableWidth,
        height: availableHeight,
        decoration: LayoutConstants.boxDecoration,
        child: Column(
          children: <Widget>[
            Container(
              height: availableHeight * 0.75,
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: ClipRRect(
                child: ContainerCacheImage(
                  altImageUrl: "https://placehold.it/130",
                  fit: BoxFit.contain,
                  imageUrl: category.bannerUrl,
                ),
              ),
            ),
            Text(
              category.title,
              textAlign: TextAlign.center,
              style: TextConstants.H8,
            ).padding(EdgeInsets.only(left: 10, right: 10))
          ],
        ),
      ),
    );
  }
}
