import 'package:bluebellapp/models/category_info_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/services/local_images_service.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'banner_dto.dart';

class StoreHomePageViewModel {
  List<BannerDto> banners;
  List<CategoryInfoDto> featuredCategories;
  List<ProductDto> featuredProducts;
  List<ProductDto> promotedFeaturedProducts;

  StoreHomePageViewModel({
    @required this.banners,
    @required this.featuredCategories,
    @required this.featuredProducts,
    @required this.promotedFeaturedProducts,
  });

  factory StoreHomePageViewModel.fromJson(String str) {
    return StoreHomePageViewModel.fromMap(json.decode(str));
  }

  String toJson() => json.encode(toMap());

  StoreHomePageViewModel.fromMap(Map<String, dynamic> json) {
    banners = json["banners"] == null
        ? List<BannerDto>()
        : List<BannerDto>.from(
            json["banners"].map((x) => BannerDto.fromMap(x)));
    featuredCategories = json["featuredCategories"] == null
        ? List<CategoryInfoDto>()
        : List<CategoryInfoDto>.from(
            json["featuredCategories"].map((x) => CategoryInfoDto.fromMap(x)));
    featuredProducts = json["featuredProducts"] == null
        ? List<ProductDto>()
        : List<ProductDto>.from(
            json["featuredProducts"].map((x) => ProductDto.fromMap(x)));
    promotedFeaturedProducts = json["promotedProducts"] == null
        ? List<ProductDto>()
        : List<ProductDto>.from(
            json["promotedProducts"].map((x) => ProductDto.fromMap(x)));
  }

  Map<String, dynamic> toMap() => {
        "banners": banners == null
            ? null
            : List<BannerDto>.from(banners.map((x) => x.toMap())),
        //"allCategories": allCategories == null ? null : List<CategoryDto>.from(allCategories.map((x) => x.toMap())),
        // "featuredCategories": featuredCategories == null ? null : List<CategoryDto>.from(featuredCategories.map((x) => x.toMap())),
        "featuredProducts": featuredProducts == null
            ? null
            : List<ProductDto>.from(featuredProducts.map((x) => x)),
        "promotedFeaturedProducts": promotedFeaturedProducts == null
            ? null
            : List<ProductDto>.from(promotedFeaturedProducts.map((x) => x)),
      };

  Future<void> setImagesPath() async {
    if (banners != null && banners.length > 0) {
      for (var banner in banners) {
        banner.bannerUrl =
            await LocalImageService.getLocalImagePath(banner.bannerUrl) ??
                banner.bannerUrl;
      }
    }
    if (featuredCategories != null && featuredCategories.length > 0) {
      for (var item in featuredCategories) {
        item.bannerUrl =
            await LocalImageService.getLocalImagePath(item.bannerUrl) ??
                item.bannerUrl;
      }
    }
    if (featuredProducts != null && featuredProducts.length > 0) {
      for (var item in featuredProducts) {
        item.pictureThumb =
            await LocalImageService.getLocalImagePath(item.pictureThumb) ??
                item.pictureThumb;
      }
    }

    if (promotedFeaturedProducts != null &&
        promotedFeaturedProducts.length > 0) {
      for (var item in promotedFeaturedProducts) {
        item.pictureThumb =
            await LocalImageService.getLocalImagePath(item.pictureThumb) ??
                item.pictureThumb;
      }
    }
  }
}
