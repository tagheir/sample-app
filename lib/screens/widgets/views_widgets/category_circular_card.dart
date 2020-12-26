import 'package:bluebellapp/models/banner_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/themes/theme.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/bloc/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryCircleCard extends StatelessWidget {
  final BannerDto categoryInfoDto;
  final Function onTap;
  final height;
  final width;
  CategoryCircleCard(
      {this.categoryInfoDto, this.height, this.width, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: GestureDetector(
            onTap: () {
              context.addEvent(CategoryScreenEvent(
                  guid: categoryInfoDto.seName,
                  isSearch: false,
                  isService: false));
            },
            child: SizedBox(
                width: this.width,
                height: this.height,
                child: ContainerCacheImage(
                  altImageUrl: "https://placehold.it/600",
                  imageUrl: categoryInfoDto?.bannerUrl,
                  fit: BoxFit.cover,
                )),
          ),
        ),
        LayoutConstants.sizedBox10H,
        Container(
          width: 110,
          child: Text(categoryInfoDto.title,
                  textAlign: TextAlign.center,
                  style: TextConstants.H8
                      .apply(color: AppTheme.lightTheme.primaryColor))
              .padding(EdgeInsets.only(left: 8, right: 8)),
        )
      ],
    );
  }
}
