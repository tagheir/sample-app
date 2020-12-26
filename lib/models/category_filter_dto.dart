import 'dart:convert';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/models/product_info_dto.dart';
import 'banner_dto.dart';

CategoryFilterDto categoryFilterDtoFromJson(String str) =>
    CategoryFilterDto.fromJson(json.decode(str));

String categoryFilterDtoToJson(CategoryFilterDto data) =>
    json.encode(data.toJson());

class CategoryFilterDto {
  CategoryFilterDto({
    this.name,
    this.subCategories,
    this.productSpecificationAttributeInfo,
    this.total,
    this.next,
    this.previous,
    this.data,
  });

  String name;
  List<BannerDto> subCategories;
  List<ProductSpecificationAttributeInfo> productSpecificationAttributeInfo;
  int total;
  int next;
  int previous;
  List<ProductDto> data;

  factory CategoryFilterDto.fromJson(String str) =>
      CategoryFilterDto.fromMap(json.decode(str));

  factory CategoryFilterDto.fromMap(Map<String, dynamic> json) {
    return CategoryFilterDto(
      name: json["name"] == "Products" ? "Categories" : json["name"],
      subCategories: json["subCategories"] == null
          ? List<BannerDto>()
          : List<BannerDto>.from(
              json["subCategories"].map((x) => BannerDto.fromMap(x))),
      productSpecificationAttributeInfo:
          json["productSpecificationAttributeInfo"] == null
              ? List<ProductSpecificationAttributeInfo>()
              : List<ProductSpecificationAttributeInfo>.from(
                  json["productSpecificationAttributeInfo"].map(
                      (x) => ProductSpecificationAttributeInfo.fromMap(x))),
      total: json["total"],
      next: json["next"],
      previous: json["previous"],
      data: json["data"] == null
          ? List<ProductDto>()
          : List<ProductDto>.from(
              json["data"].map((x) => ProductDto.fromMap(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "subCategories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
        "productSpecificationAttributeInfo": List<dynamic>.from(
            productSpecificationAttributeInfo.map((x) => x.toJson())),
        "total": total,
        "next": next,
        "previous": previous,
        "data": List<ProductDto>.from(data.map((x) => x.toJson())),
      };
}

class ProductSpecificationAttributeInfo {
  ProductSpecificationAttributeInfo({
    this.name,
    this.productSpecificationAttributeInfoOptions,
  });

  String name;
  List<ProductSpecificationAttributeInfoOption>
      productSpecificationAttributeInfoOptions;

  factory ProductSpecificationAttributeInfo.fromMap(
          Map<String, dynamic> json) =>
      ProductSpecificationAttributeInfo(
        name: json["name"],
        productSpecificationAttributeInfoOptions:
            List<ProductSpecificationAttributeInfoOption>.from(
                json["productSpecificationAttributeInfoOptions"].map(
                    (x) => ProductSpecificationAttributeInfoOption.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "productSpecificationAttributeInfoOptions": List<dynamic>.from(
            productSpecificationAttributeInfoOptions.map((x) => x.toJson())),
      };
}

class ProductSpecificationAttributeInfoOption {
  ProductSpecificationAttributeInfoOption({
    this.id,
    this.name,
    this.isPreSelected,
  });

  int id;
  String name;
  bool isPreSelected;

  factory ProductSpecificationAttributeInfoOption.fromMap(
          Map<String, dynamic> json) =>
      ProductSpecificationAttributeInfoOption(
        id: json["id"],
        name: json["name"],
        isPreSelected: json["isPreSelected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isPreSelected": isPreSelected,
      };
}
