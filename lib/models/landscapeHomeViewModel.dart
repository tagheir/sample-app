import 'dart:convert';
import 'banner_dto.dart';
import 'category_info_dto.dart';
import 'package:bluebellapp/services/local_images_service.dart';

class LandscapeHomeViewModel {
  LandscapeHomeViewModel({
    this.banners,
    this.services,
  });
  List<BannerDto> banners;
  List<CategoryInfoDto> services;

  factory LandscapeHomeViewModel.fromJson(String str) {
    return LandscapeHomeViewModel.fromMap(json.decode(str));
  }

  static LandscapeHomeViewModel getLandscapeHomeViewModel() =>
      LandscapeHomeViewModel(banners: [
        BannerDto(
            title: "Landscape Design & Installation",
            bannerUrl:
                "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005596_landscape-design-installation.jpg",
            seName: "landscape-design-and-installation-service"),
        BannerDto(
            title: "Garden Maintenance",
            bannerUrl:
                "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005611_banner-480x231-px-2-.jpeg",
            seName: "garden-and-lawn-maintenance-service"),
        BannerDto(
            title: "Landscape Consultancy",
            bannerUrl:
                "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005608_0005609-landscape-cunsultancy1-1-.jpeg",
            seName: "garden-and-landscape-consultancy-service"),
        BannerDto(
            title: "Planters",
            bannerUrl:
                "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005613_banner-480x231-px-1-1-.jpeg",
            seName: "planters-service"),
      ], services: [
        CategoryInfoDto(
            description: null,
            templateTypeName: "CategoryTemplate.LandscapeService",
            backgroundUrl:
                "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005596_landscape-design-installation.jpg",
            title: "Landscape Design & Installation",
            bannerUrl:
                "https://landscape.bluebell.pk/img/landscape/installation-design.png",
            seName: "landscape-design-and-installation-service"),
        CategoryInfoDto(
            description: null,
            templateTypeName: "CategoryTemplate.LandscapeService",
            backgroundUrl:
                "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005611_banner-480x231-px-2-.jpeg",
            title: "Garden Maintenance",
            bannerUrl:
                "https://landscape.bluebell.pk/img/landscape/maintenance.png",
            seName: "garden-and-lawn-maintenance-service"),
        CategoryInfoDto(
            description: null,
            templateTypeName: "CategoryTemplate.LandscapeService",
            backgroundUrl:
                "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005608_0005609-landscape-cunsultancy1-1-.jpeg",
            title: "Landscape Consultancy",
            bannerUrl:
                "https://landscape.bluebell.pk/img/landscape/consultancy.png",
            seName: "garden-and-landscape-consultancy-service"),
        CategoryInfoDto(
            description: null,
            templateTypeName: "CategoryTemplate.LandscapeService",
            backgroundUrl:
                "https://bluebellcdnstorage.s3.ap-south-1.amazonaws.com/0005613_banner-480x231-px-1-1-.jpeg",
            title: "Planters",
            bannerUrl:
                "https://landscape.bluebell.pk/img/landscape/planters.png",
            seName: "planters-service")
      ]);

  String toJson(LandscapeHomeViewModel data) => json.encode(data.toMap());

  factory LandscapeHomeViewModel.fromMap(Map<String, dynamic> json) {
    return LandscapeHomeViewModel(
      banners: List<BannerDto>.from(
          json["banners"].map((x) => BannerDto.fromMap(x))),
      services: List<CategoryInfoDto>.from(
          json["services"].map((x) => CategoryInfoDto.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
        "banners": List<CategoryInfoDto>.from(banners.map((x) => x.toJson())),
        "services": List<CategoryInfoDto>.from(services.map((x) => x.toJson())),
      };

  Future<void> setLandscapeImagesPath() async {
    if (banners != null) {
      for (var banner in banners) {
        banner.bannerUrl =
            await LocalImageService.getLocalImagePath(banner.bannerUrl) ??
                banner.bannerUrl;
      }
    }
    if (services != null) {
      for (var service in services) {
        service.bannerUrl =
            await LocalImageService.getLocalImagePath(service.bannerUrl) ??
                service.bannerUrl;
        service.backgroundUrl =
            await LocalImageService.getLocalImagePath(service.backgroundUrl) ??
                service.backgroundUrl;
      }
    }
  }
}
