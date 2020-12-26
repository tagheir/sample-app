import 'dart:convert';
import 'package:bluebellapp/models/customerAddress_dto.dart';
import 'package:bluebellapp/models/order_item_dto.dart';

import 'order_compact_dto.dart';

class OrderDetailDto extends OrderCompactDto {
  int id;
  String orderGuid;
  double orderTax;
  double orderDiscount;
  String taxRates;
  String billingAddress;
  String shippingAddress;
  List<OrderItem> orderItems;

  OrderDetailDto(
      {this.orderGuid,
      this.orderTax,
      this.orderDiscount,
      this.billingAddress,
      this.shippingAddress,
      this.orderItems,
      this.id});

  factory OrderDetailDto.fromJson(String str) =>
      OrderDetailDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<OrderDetailDto> parseJsonList(String jsonStr) {
    List<OrderDetailDto> list = null;
    try {
      if (jsonStr.isNotEmpty) {
        list = (json.decode(jsonStr) as List)
            .map((data) => OrderDetailDto.fromMap(data))
            .toList();
      }
    } catch (ex) {
      ////print(ex);
    }
    return list;
  }

  OrderDetailDto.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    orderGuid = json['orderGuid'];
    orderStatus = json['orderStatus'];
    shippingStatus = json['shippingStatus'];
    paymentStatus = json['paymentStatus'];
    paymentMethodSystemName = json['paymentMethodSystemName'];
    taxRates = json['taxRates'];
    orderTax = (json['orderTax'] as num)?.toDouble();
    orderDiscount = (json['orderDiscount'] as num)?.toDouble();
    orderTotal = (json['orderTotal'] as num)?.toDouble();
    createdOnUtc = json['createdOnUtc'];
    billingAddress = json['billingAddress'];
    shippingAddress = json['shippingAddress'];
    orderItems = json['orderItems'] != null
        ? List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromMap(x)))
        : List<OrderItem>();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderGuid'] = this.orderGuid;
    data['orderStatusId'] = this.orderStatus;
    data['shippingStatusId'] = this.shippingStatus;
    data['paymentStatusId'] = this.paymentStatus;
    data['paymentMethodSystemName'] = this.paymentMethodSystemName;
    data['taxRates'] = this.taxRates;
    data['orderTax'] = this.orderTax;
    data['orderDiscount'] = this.orderDiscount;
    data['orderTotal'] = this.orderTotal;
    data['createdOnUtc'] = this.createdOnUtc;

    data['id'] = this.id;
    return data;
  }
}
