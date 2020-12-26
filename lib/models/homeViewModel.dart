import 'dart:convert';
import 'package:bluebellapp/services/local_images_service.dart';

import 'banner_dto.dart';
import 'category_info_dto.dart';

class ServicesHomeViewModel {
  ServicesHomeViewModel({
    this.banners,
    this.services,
  });
  List<BannerDto> banners;
  List<CategoryInfoDto> services;

  factory ServicesHomeViewModel.fromJson(String str) {
    ////print(str);
    if (str != null) {
      return ServicesHomeViewModel.fromMap(json.decode(str));
    }
    return null;
  }

  factory ServicesHomeViewModel.fromMap(Map<String, dynamic> json) {
    return ServicesHomeViewModel(
      banners: List<CategoryInfoDto>.from(
          json["banners"].map((x) => CategoryInfoDto.fromMap(x))),
      services: List<CategoryInfoDto>.from(
          json["services"].map((x) => CategoryInfoDto.fromMap(x))),
    );
  }

  setImagesPath() async {
    if (banners != null && banners.length > 0) {
      for (var banner in banners) {
        banner.bannerUrl =
            await LocalImageService.getLocalImagePath(banner.bannerUrl) ??
                banner.bannerUrl;
      }
    }
    if (services != null && services.length > 0) {
      for (var service in services) {
        service.bannerUrl =
            await LocalImageService.getLocalImagePath(service.bannerUrl) ??
                service.bannerUrl;
      }
    }
  }
}
