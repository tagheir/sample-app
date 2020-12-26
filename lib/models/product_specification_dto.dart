import 'dart:convert';

class ProductSpecificationDto {
  String key;
  String option;

  ProductSpecificationDto({this.key, this.option});

  factory ProductSpecificationDto.fromJson(String str) =>
      ProductSpecificationDto.fromMap(json.decode(str));

  ProductSpecificationDto.fromMap(Map<String, dynamic> json) {
    key = json['key'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['option'] = this.option;
    return data;
  }
}
