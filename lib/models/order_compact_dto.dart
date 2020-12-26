import 'dart:convert';

class OrderCompactDto {
  int id;
  String orderGuid;
  String orderStatus;
  String shippingStatus;
  String paymentStatus;
  String paymentMethodSystemName;
  double orderTotal;
  String createdOnUtc;

  OrderCompactDto({this.id, this.orderGuid});

  factory OrderCompactDto.fromJson(String str) =>
      OrderCompactDto.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  OrderCompactDto.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    orderGuid = json['orderGuid'];
    orderStatus = json['orderStatus'];
    //shippingStatus = json['shippingStatus'];
    paymentStatus = json['paymentStatus'];
    paymentMethodSystemName = json['paymentMethodSystemName'].toString().isEmpty
        ? "Cash"
        : json['paymentMethodSystemName'];
    orderTotal = (json['orderTotal'] as num).toDouble();
    createdOnUtc = json['createdOnUtc'];
  }

  static List<OrderCompactDto> parseJsonList(String jsonStr) {
    List<OrderCompactDto> list = null;
    try {
      if (jsonStr.isNotEmpty) {
        list = (json.decode(jsonStr) as List)
            .map((data) => OrderCompactDto.fromMap(data))
            .toList();
      }
    } catch (ex) {
      ////print(ex);
    }
    return list;
  }
}
