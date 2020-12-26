import 'package:bluebellapp/resources/constants/helper_constants/layout_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/text_constants.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';
import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class LandscapeProjectCard extends StatelessWidget {
  String title;
  String location;
  String imagePath;
  double availableWidth;
  double availableHeight;
  Function onTap;
  LandscapeProjectCard(
      {this.title,
      this.location,
      this.imagePath,
      this.availableHeight,
      this.availableWidth,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    this.availableHeight ??= this.availableWidth / 1.8;
    return GestureDetector(
      onTap: () {
        if (this.onTap != null) {
          this.onTap();
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4, bottom: 10),
        width: this.availableWidth,
        height: this.availableHeight,
        decoration: LayoutConstants.boxDecoration,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: LayoutConstants.borderRadius8,
            topRight: LayoutConstants.borderRadius8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: this.availableWidth,
                height: this.availableHeight * 0.8,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: LayoutConstants.borderRadius8,
                      topRight: LayoutConstants.borderRadius8,
                    ),
                    child: ContainerCacheImage(
                      altImageUrl: "https://placehold.it/600",
                      imageUrl: imagePath,
                      fit: BoxFit.cover,
                    )),
              ),
              LayoutConstants.sizedBox5H,
              Text(this.title,
                      style:
                          TextConstants.H6.apply(color: LightColor.landGreen))
                  .padding(EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5)),
              Text(this.location,
                      style: TextConstants.H7.apply(color: LightColor.navy))
                  .padding(EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
