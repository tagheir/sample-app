import 'dart:convert';

import 'package:bluebellapp/models/shoppingCart_dto.dart';

class UpdateCartDto {
  bool success;
  bool updateCart;
  bool updateWishList;
  String message;
  List<String> warning;
  ShoppingCartDto shoppingCart;
  int cartCount;

  UpdateCartDto(
      {this.success,
      this.updateCart,
      this.updateWishList,
      this.message,
      this.warning,
      this.shoppingCart,
      this.cartCount});

  factory UpdateCartDto.fromJson(String str) {
    return UpdateCartDto.fromMap(json.decode(str));
  }

  UpdateCartDto.fromMap(Map<String, dynamic> json) {
    success = json['success'];
    updateCart = json['updateCart'];
    updateWishList = json['updateWishList'];
    message = json['message'];
    if (json['warning'] != null) {
      warning = List<String>();
      json['warning'].forEach((v) {
        warning.add(v);
      });
    }
    shoppingCart = json['shoppingCart'] != null
        ? ShoppingCartDto.fromMap(json['shoppingCart'])
        : ShoppingCartDto();
    cartCount = json['cartCount'];
  }
}
