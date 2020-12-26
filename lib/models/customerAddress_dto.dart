import 'dart:convert';

class CustomerAddressDto {
  int id;
  String firstName;
  String lastName;
  String email;
  String company;
  String address1;
  String address2;
  String zipPostalCode;
  // int countryId;
  // int stateProvinceId;
  String city;
  String phoneNumber;
  // String faxNumber;
  // String createdOnUtc;
  // int customerId;
  // String countryName;
  // String countryCode;
  // String stateProvinceName;
  // bool isShippingAddress;
  // bool isBillingAddress;

  CustomerAddressDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.company,
    // this.countryId,
    // this.stateProvinceId,
    this.city,
    this.address1,
    this.address2,
    this.zipPostalCode,
    // this.phoneNumber,
    // this.faxNumber,
    // this.createdOnUtc,
    // this.customerId,
    // this.countryName,
    // this.countryCode,
    // this.stateProvinceName
  });

  factory CustomerAddressDto.fromJson(String str) {
    return CustomerAddressDto.fromMap(json.decode(str));
  }

  static List<CustomerAddressDto> parseJsonList(String str) {
    var address = List<CustomerAddressDto>();
    if (str.isNotEmpty) {
      address = (json.decode(str) as List)
          .map((data) => CustomerAddressDto.fromMap(data))
          .toList();
    }
    return address;
  }

  String toJson() => json.encode(toMap());

  CustomerAddressDto.fromMap(Map<String, dynamic> json) {
    id = json['id'] == null ? 0 : json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    company = json['company'];
    // countryId = json['countryId'] == null ? 0 : json['countryId'];
    // stateProvinceId =
    //     json['stateProvinceId'] == null ? 0 : json['stateProvinceId'];
    city = json['city'];
    address1 = json['address1'];
    address2 = json['address2'];
    zipPostalCode = json['zipPostalCode'];
    // phoneNumber = json['phoneNumber'];
    // faxNumber = json['faxNumber'];
    // createdOnUtc = json['createdOnUtc'];
    // customerId = json['customerId'] == null ? 0 : json['customerId'];
    // countryName = json['countryName'];
    // countryCode = json['countryCode'];
    // stateProvinceName = json['stateProvinceName'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id == null ? 0 : this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['company'] = this.company;
    // data['countryId'] = this.countryId == null ? 0 : this.customerId;
    // data['stateProvinceId'] =
    //     this.stateProvinceId == null ? 0 : this.stateProvinceId;
    data['city'] = this.city;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['zipPostalCode'] = this.zipPostalCode;
    // data['phoneNumber'] = this.phoneNumber;
    // data['faxNumber'] = this.faxNumber;
    // data['createdOnUtc'] = this.createdOnUtc == null ? null : this.createdOnUtc.toIso8601String();
    // data['customerId'] = this.customerId == null ? 0 : this.customerId;
    // data['countryName'] = this.countryName;
    // data['countryCode'] = this.countryCode;
    // data['stateProvinceName'] = this.stateProvinceName;
    return data;
  }
}
