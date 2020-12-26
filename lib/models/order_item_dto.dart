import 'dart:convert';
import 'package:bluebellapp/models/product_attribute_dto.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';

class OrderItem {
  int productId;
  String productName;
  String pictureThumb;
  int quantity;
  double price;
  String picture;
  List<ProductCompactAttribute> productAttributes;
  OrderItem({
    this.productId,
    this.quantity,
    this.picture,
    this.pictureThumb,
    this.price,
    this.productName,
    this.productAttributes,
  });

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  OrderItem.fromMap(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    quantity = json['quantity'];
    price = (json['price'] as num).toDouble();
    picture = json['picture'] == null ? null : json['picture'];
    pictureThumb = json['pictureThumb'] == null
        ? null
        : ApiRoutes.CdnPath + json['pictureThumb'];
    productAttributes = json['productAttributes'] == null
        ? List<ProductCompactAttribute>()
        : ProductCompactAttribute.fromMapList(json['productAttributes']);
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['pictureThumb'] = this.pictureThumb;
    data['quqntity'] = this.quantity;
    data['price'] = this.price;
    data['picture'] = this.picture;
    return data;
  }

  static List<OrderItem> fromJsonList(String str) {
    return (json.decode(str) as List).map((f) => OrderItem.fromMap(f)).toList();
  }

  static List<OrderItem> fromMapList(List<Map<String, dynamic>> json) {
    List<OrderItem> orderItem;
    if (json != null) {
      orderItem = List<OrderItem>();
      json.forEach((v) {
        orderItem.add(OrderItem.fromMap(v));
      });
      return orderItem;
    }
    return List<OrderItem>();
  }
}
