import 'dart:convert';
import 'package:bluebellapp/models/product_attribute_dto.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';
import 'package:bluebellapp/resources/constants/helper_constants/template_type.dart';

class ShoppingCartResponse {
  bool success;
  bool updateCart;
  bool updateWishList;
  String message;
  List<String> warning;
  ShoppingCartDto shoppingCart;
  int cartCount;

  ShoppingCartResponse(
      {this.success,
      this.updateCart,
      this.updateWishList,
      this.message,
      this.warning,
      this.shoppingCart,
      this.cartCount});

  factory ShoppingCartResponse.fromJson(String str) =>
      ShoppingCartResponse.fromMap(json.decode(str));

  ShoppingCartResponse.fromMap(Map<String, dynamic> json) {
    success = json['success'];
    updateCart = json['updateCart'];
    updateWishList = json['updateWishList'];
    message = json['message'];
    if (json['warning'] != null) {
      json['warning'].cast<String>();
    }
    shoppingCart = json['shoppingCart'] != null
        ? ShoppingCartDto.fromMap(json['shoppingCart'])
        : null;
    cartCount = json['cartCount'];
  }
}

class ShoppingCartDto {
  List<ShoppingCartItem> shoppingCartItems;
  int totalQuantity;
  double totalCost;

  ShoppingCartDto({this.shoppingCartItems, this.totalQuantity, this.totalCost});

  factory ShoppingCartDto.fromJson(String str) =>
      ShoppingCartDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  ShoppingCartDto.fromMap(Map<String, dynamic> json) {
    totalQuantity = json['totalQuantity'];
    totalCost = json['totalCost'] == 0 ? 0.0 : json['totalCost'];
    if (json['shoppingCartItems'] != null) {
      shoppingCartItems = List<ShoppingCartItem>();
      json['shoppingCartItems'].forEach((v) {
        shoppingCartItems.add(ShoppingCartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //////print("======before shppoing cart======");
    if (this.shoppingCartItems != null) {
      data['shoppingCartItems'] =
          this.shoppingCartItems.map((v) => v.toJson()).toList();
    }
    //////print("======after shppoing cart======");
    data['totalQuantity'] = this.totalQuantity;
    data['totalCost'] = this.totalCost;
    return data;
  }
}

class ShoppingCartItem {
  int id;
  String picture;
  int productId;
  String productName;
  String templateName;
  String seName;
  List<ProductCompactAttribute> productAttributes;
  int quantity;
  double pricePerUnit;
  double totalPrice;
  ShoppingCartItem({
    this.id,
    this.productId,
    this.quantity,
    this.pricePerUnit,
    this.totalPrice,
    this.productName,
    this.picture,
    this.templateName,
    this.seName,
    this.productAttributes,
  });

  factory ShoppingCartItem.fromMap(String str) =>
      ShoppingCartItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  ShoppingCartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? 0 : json['id'];
    productId = int.parse(json['productId']);
    quantity = json['quantity'] == null ? 0 : json['quantity'];
    pricePerUnit =
        json['pricePerUnit'] == null ? 0.0 : json['pricePerUnit'] as double;
    totalPrice = json['totalPrice'] == null ? 0 : json['totalPrice'];
    productName = json['productName'];
    picture =
        json['picture'] == null ? null : ApiRoutes.CdnPath + json['picture'];
    templateName = json['templateName'];
    seName = json['seName'];
    //////print(json['templateType']);
    productAttributes = json['productAttributes'] != null
        ? ProductCompactAttribute.fromMapList(json['productAttributes'])
        : List<ProductCompactAttribute>();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['pricePerUnit'] = this.pricePerUnit;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}

enum CartOperation {
  INCREMENT_CART_ITEM,
  DECREMENT_CART_ITEM,
  REMOVE_CART_ITEM,
  CART_CHECKOUT
}
