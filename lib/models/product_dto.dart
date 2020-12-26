import 'dart:convert';
import 'package:bluebellapp/resources/constants/api_routes.dart';
import 'package:bluebellapp/resources/constants/helper_constants/template_type.dart';

class ProductDto {
  String name;
  String seName;
  int price;
  List<String> pictures;
  String pictureThumb;
  TemplateType templateTypeName;
  ProductDto({
    this.name,
    this.seName,
    this.price,
    this.pictures,
    this.templateTypeName,
  });

  factory ProductDto.fromJson(String str) =>
      ProductDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<ProductDto> fromJsonList(String str) {
    return (json.decode(str) as List)
        .map((f) => ProductDto.fromMap(f))
        .toList();
  }

  static List<ProductDto> fromMapList(Iterable<dynamic> json) {
    return List<ProductDto>.from(json.map((x) => ProductDto.fromMap(x)));
  }

  ProductDto.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    seName = json['seName'];
    price = json['price'];
    templateTypeName =
        TemplateTypeHelper.getTemplateTypeOfProduct(json['templateTypeName']);
    pictures = json['pictures'].cast<String>();
    if (pictures != null) {
      if (pictures.length > 0) {
        pictures = pictures.map((e) {
          if (e == null) return e;
          if (e.contains(ApiRoutes.CdnPath)) return e;
          return ApiRoutes.CdnPath + e;
        }).toList();
        pictureThumb = pictures.first;
      }
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pictures'] = this.pictures;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
