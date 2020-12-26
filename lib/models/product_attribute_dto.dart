import 'dart:convert';

class ProductCompactAttribute {
  String name;
  String value;

  ProductCompactAttribute({this.name, this.value});

  factory ProductCompactAttribute.fromJson(String str) =>
      ProductCompactAttribute.fromMap(json.decode(str));

  ProductCompactAttribute.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  static List<ProductCompactAttribute> fromJsonList(String str) {
    return (json.decode(str) as List)
        .map((f) => ProductCompactAttribute.fromMap(f))
        .toList();
  }

  static List<ProductCompactAttribute> fromMapList(Iterable<dynamic> json) {
    return List<ProductCompactAttribute>.from(
        json.map((x) => ProductCompactAttribute.fromMap(x)));
  }
}
