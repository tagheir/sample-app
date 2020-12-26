import 'dart:convert';
import 'package:bluebellapp/models/category_dto.dart';
import 'package:bluebellapp/models/product_specification_dto.dart';
import 'package:bluebellapp/resources/constants/helper_constants/template_type.dart';
import 'package:bluebellapp/services/local_images_service.dart';

class ProductDetailDto {
  int id;
  String basepriceBaseAmount;
  double productCost;
  double price;
  String fullDescription;
  String name;
  String parentGroupedProductId;
  int productTypeId;
  String picturesJson;
  int categoryId;
  CategoryDto category;
  String pictureWithCdn;
  String templateName;
  TemplateType templateType;
  List<String> picturesWithCdn;
  List<ProductAttribute> productAttributes;
  List<ProductSpecificationDto> productSpecs;

  ProductDetailDto(
      {this.id,
      this.name,
      this.productCost,
      this.price,
      this.fullDescription,
      this.basepriceBaseAmount,
      this.parentGroupedProductId,
      this.productTypeId,
      this.picturesJson,
      this.categoryId,
      this.category,
      this.pictureWithCdn,
      this.templateName,
      this.templateType,
      this.productSpecs,
      this.picturesWithCdn});

  factory ProductDetailDto.fromJson(String str) =>
      ProductDetailDto.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  ProductDetailDto.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productCost = (json['productCost'] as num).toDouble();
    price = (json['price'] as num).toDouble();
    fullDescription = json['fullDescription'];
    basepriceBaseAmount = json['basepriceBaseAmount'];
    parentGroupedProductId = json['parentGroupedProductId'];
    productTypeId = json['productTypeId'];
    picturesJson = json['picturesJson'];
    categoryId = json['categoryId'];
    templateType = TemplateTypeHelper.getTemplateTypeOfProduct(templateName);
    productAttributes = json['productAttributes'] != null
        ? List<ProductAttribute>.from(
            json["productAttributes"].map((x) => ProductAttribute.fromMap(x)))
        : List<ProductAttribute>();
    productSpecs = json['productSpecs'] == null
        ? List<ProductSpecificationDto>()
        : List<ProductSpecificationDto>.from(json["productSpecs"]
            .map((x) => ProductSpecificationDto.fromMap(x)));
    picturesWithCdn = json['picturesWithCdn'].cast<String>();
    if (picturesWithCdn != null && picturesWithCdn.length > 0) {
      pictureWithCdn = picturesWithCdn.first;
    }
  }

  setProductImagePath() async {
    if (pictureWithCdn != null) {
      pictureWithCdn =
          await LocalImageService.getLocalImagePath(pictureWithCdn) ??
              pictureWithCdn;
    }
  }
}

class ProductAttribute {
  int id;
  String textPrompt;
  String productAttributeId;
  String productAttributeName;
  List<AttributeValue> attributeValues;

  ProductAttribute({
    this.id,
    this.textPrompt,
    this.productAttributeId,
    this.productAttributeName,
    this.attributeValues,
  });

  factory ProductAttribute.fromJson(String str) =>
      ProductAttribute.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  ProductAttribute.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    textPrompt = json['textPrompt'];
    productAttributeId = json['productAttributeId'];
    productAttributeName = json['productAttributeName'];
    attributeValues = json['attributeValues'] == null
        ? null
        : List<AttributeValue>.from(
            json["attributeValues"].map((x) => AttributeValue.fromMap(x)));
  }

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "textPrompt": textPrompt == null ? null : textPrompt,
        "productAttributeId":
            productAttributeId == null ? null : productAttributeId,
        "productAttributeName":
            productAttributeName == null ? null : productAttributeName,
        "attributeValues": attributeValues == null
            ? null
            : List<dynamic>.from(attributeValues.map((x) => x.toMap())),
      };
}

class AttributeValue {
  int id;
  String name;
  int quantity;
  int priceAdjustment;

  AttributeValue({
    this.id,
    this.name,
    this.quantity,
    this.priceAdjustment,
  });

  factory AttributeValue.fromJson(String str) =>
      AttributeValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttributeValue.fromMap(Map<String, dynamic> json) {
    AttributeValue attrVal = AttributeValue();
    attrVal.id = json["id"] == null ? 0 : json["id"];
    attrVal.name = json["name"] == null ? null : json["name"];
    attrVal.quantity = json["quantity"] == null ? 0 : json["quantity"];
    attrVal.priceAdjustment =
        json["priceAdjustment"] == null ? 0 : json["priceAdjustment"];
    return attrVal;
  }

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "quantity": quantity == null ? null : quantity,
        "priceAdjustment": priceAdjustment == null ? null : priceAdjustment,
      };
}
