import 'dart:convert';
import 'package:bluebellapp/models/category_info_dto.dart';
import 'package:bluebellapp/services/local_images_service.dart';

import 'banner_dto.dart';

class DashBoardViewModel {
  List<BannerDto> banners;
  DashBoardViewModel({this.banners});
  factory DashBoardViewModel.fromJson(String str) {
    return DashBoardViewModel.fromMap(json.decode(str));
  }
  factory DashBoardViewModel.fromMap(Map<String, dynamic> json) =>
      DashBoardViewModel(
        banners: List<CategoryInfoDto>.from(
            json["banners"].map((x) => CategoryInfoDto.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
      };

  setBannersImagesPath() async {
    if (banners != null) {
      for (var banner in banners) {
        banner.bannerUrl =
            await LocalImageService.getLocalImagePath(banner.bannerUrl) ??
                banner.bannerUrl;
      }
    }
  }
}
