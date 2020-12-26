// To parse this JSON data, do
//
//     final customerAddress = customerAddressFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CustomerAddress {
  Address address;

  CustomerAddress({
    @required this.address,
  });

  factory CustomerAddress.fromJson(String str) =>
      CustomerAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerAddress.fromMap(Map<String, dynamic> json) => CustomerAddress(
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
      );

  Map<String, dynamic> toMap() => {
        "address": address == null ? null : address.toMap(),
      };
}

class Address {
  int id;
  String firstName;
  String lastName;
  String email;
  String city;
  String address1;
  String address2;
  String zipPostalCode;
  String phoneNumber;

  Address({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.city,
    this.address1,
    this.address2,
    this.zipPostalCode,
    this.phoneNumber,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        email: json["email"] == null ? null : json["email"],
        city: json["city"] == null ? null : json["city"],
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        zipPostalCode:
            json["zipPostalCode"] == null ? null : json["zipPostalCode"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "city": city == null ? null : city,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "zipPostalCode": zipPostalCode == null ? null : zipPostalCode,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
      };
}
