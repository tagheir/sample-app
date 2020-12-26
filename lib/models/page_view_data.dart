import 'package:flutter/widgets.dart';
import 'package:bluebellapp/screens/widgets/cache_image_widgets/container_cache_image.dart';

class SliderViewDto {
  final String titleText;
  final String subText;
  final String assetsImage;
  Widget assetsImageWidget;
  final Function onClick;

  SliderViewDto({
    this.titleText,
    this.subText,
    this.assetsImage,
    this.onClick,
  }) {
    assetsImageWidget = ContainerCacheImage(
      altImageUrl: "https://placehold.it/600",
      imageUrl: assetsImage,
      fit: BoxFit.cover,
    );
  }
}
