import 'dart:convert';

import 'package:bluebellapp/models/shoppingCart_dto.dart';

class CheckoutModel {
  ShoppingCartDto cartDto;
  String billingAddress;
  String shippingAddress;

  factory CheckoutModel.fromJson(String str) =>
      CheckoutModel.fromMap(json.decode(str));

  CheckoutModel.fromMap(Map<String, dynamic> json) {
    cartDto = ShoppingCartDto.fromMap(json['cart']);
    billingAddress = json['billingAddress'];
    shippingAddress = json['shippingAddress'];
  }
}
