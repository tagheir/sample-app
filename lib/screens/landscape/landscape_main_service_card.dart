import 'dart:io';
import 'package:bluebellapp/models/category_info_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LandscapeMainServiceCard extends StatelessWidget {
  final CategoryInfoDto serviceInfo;
  final Function onTap;
  final double height;
  LandscapeMainServiceCard({this.serviceInfo, this.onTap, this.height});
  @override
  Widget build(BuildContext context) {
    ////print(serviceInfo.bannerUrl);
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            this.onTap();
          },
          child: Container(
            height: this.height,
            decoration: LayoutConstants.boxDecoration,
            margin: EdgeInsets.only(left: 4, right: 4),
            // padding: EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(
                  color: LightColor.navy,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        LightColor.navy.withOpacity(0.2), BlendMode.dstATop),
                    image: serviceInfo.backgroundUrl.contains("https")
                        ? NetworkImage(
                            serviceInfo.backgroundUrl,
                          )
                        : FileImage(File(serviceInfo.backgroundUrl)),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ContainerCacheImage(
                    imageUrl: serviceInfo.bannerUrl,
                    altImageUrl: "https://placehold.it/130",
                    height: this.height * 0.5,
                    width: this.height * 0.5,
                    fit: BoxFit.fill,
                  ),
                  LayoutConstants.sizedBox10H,
                  Text(serviceInfo.title,
                          textAlign: TextAlign.center,
                          style:
                              TextConstants.H6.apply(color: LightColor.white))
                      .padding(EdgeInsets.only(left: 24, right: 24))
                ],
              ),
            ),
          ),
        ));
  }
}
