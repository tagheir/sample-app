import 'package:bluebellapp/resources/constants/api_routes.dart';

class ProductInfoDto {
  ProductInfoDto({
    this.name,
    this.seName,
    this.templateTypeName,
    this.price,
    this.pictures,
  });
  String name;
  String seName;
  String templateTypeName;
  int price;
  List<String> pictures;

  factory ProductInfoDto.fromMap(Map<String, dynamic> json) => ProductInfoDto(
        name: json["name"],
        seName: json["seName"],
        templateTypeName: json["templateTypeName"],
        price: json["price"],
        pictures: List<String>.from(json["pictures"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "seName": seName,
        "templateTypeName": templateTypeName,
        "price": price,
        "pictures":
            List<dynamic>.from(pictures.map((x) => ApiRoutes.CdnPath + x)),
      };
}
