import 'dart:convert';

import 'package:bluebellapp/models/customerAddress_dto.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';

class CustomerDto {
  int customerId;
  String name;
  String firstName;
  String lastName;
  String imageUrl;
  String imageBase64;
  String phoneNumber;
  String email;
  int billingAddressId;
  int shippingAddressId;
  List<CustomerAddressDto> addresses;

  CustomerDto(
      {this.customerId,
      this.firstName,
      this.lastName,
      this.imageUrl,
      this.imageBase64,
      this.phoneNumber,
      this.email,
      this.addresses,
      this.billingAddressId,
      this.shippingAddressId});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['customerId'] = this.customerId ?? 0;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['imageUrl'] = this.imageUrl;
    data['imageBase64'] = this.imageBase64;
    data['phoneNumber'] = this.phoneNumber;
    data['billingAddressId'] = this.billingAddressId;
    data['shippingAddressId'] = this.shippingAddressId;
    return data;
  }

  factory CustomerDto.fromJson(String str) {
    return CustomerDto.fromMap(json.decode(str));
  }

  CustomerDto.fromMap(Map<String, dynamic> json) {
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    imageUrl = json['imageUrl'] != null && json['imageUrl'] != ApiRoutes.CdnPath
        ? ApiRoutes.CdnPath + json['imageUrl']
        : null;
    billingAddressId =
        json['billingAddressId'] == null ? 0 : json['billingAddressId'];
    shippingAddressId =
        json['shippingAddressId'] == null ? 0 : json['shippingAddressId'];
    addresses = json['addresses'] == null
        ? List<CustomerAddressDto>()
        : addresses = List<CustomerAddressDto>();
    json['addresses'].forEach((v) {
      addresses.add(CustomerAddressDto.fromMap(v));
    });
  }
}

// String toJson() => json.encode(toMap());
