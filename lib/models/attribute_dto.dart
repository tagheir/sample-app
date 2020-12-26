class ProductAttribute {
  ProductAttributeValue productAttributeValue;
  int id;

  ProductAttribute({this.productAttributeValue, this.id});

  ProductAttribute.fromJson(Map<String, dynamic> json) {
    productAttributeValue = json['productAttributeValue'] != null
        ? new ProductAttributeValue.fromJson(json['productAttributeValue'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productAttributeValue != null) {
      data['productAttributeValue'] = this.productAttributeValue.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}
class Attributes {
  List<ProductAttribute> productAttribute;

  Attributes({this.productAttribute});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['productAttribute'] != null) {
      productAttribute = new List<ProductAttribute>();
      json['productAttribute'].forEach((v) {
        productAttribute.add(new ProductAttribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productAttribute != null) {
      data['productAttribute'] =
          this.productAttribute.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ProductAttributeValue {
  String value;
  String attributeType;
  String attributeValue;

  ProductAttributeValue({this.value, this.attributeType, this.attributeValue});

  ProductAttributeValue.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    attributeType = json['attributeType'];
    attributeValue = json['attributeValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['attributeType'] = this.attributeType;
    data['attributeValue'] = this.attributeValue;
    return data;
  }
}