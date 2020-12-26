import 'dart:convert';

import 'package:bluebellapp/models/customerAddress_dto.dart';
import 'package:bluebellapp/models/customer_dto.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';

class CustomerDetailDto {
  String customerGuid;
  String username;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String emailToRevalidate;
  String adminComment;
  bool isTaxExempt;
  int affiliateId;
  int vendorId;
  bool hasShoppingCartItems;
  bool requireReLogin;
  int failedLoginAttempts;
  DateTime cannotLoginUntilDateUtc;
  bool active;
  bool deleted;
  bool isSystemAccount;
  String systemName;
  String lastIpAddress;
  DateTime createdOnUtc;
  DateTime lastLoginDateUtc;
  DateTime lastActivityDateUtc;
  int registeredInStoreId;
  int billingAddressId;
  int shippingAddressId;
  String addressesXml;
  String genericAttributesXml;
  AddressesList addressesList;
  GenericAttributes genericAttributes;
  int id;

  CustomerDetailDto(
      {this.customerGuid,
      this.username,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.emailToRevalidate,
      this.adminComment,
      this.isTaxExempt,
      this.affiliateId,
      this.vendorId,
      this.hasShoppingCartItems,
      this.requireReLogin,
      this.failedLoginAttempts,
      this.cannotLoginUntilDateUtc,
      this.active,
      this.deleted,
      this.isSystemAccount,
      this.systemName,
      this.lastIpAddress,
      this.createdOnUtc,
      this.lastLoginDateUtc,
      this.lastActivityDateUtc,
      this.registeredInStoreId,
      this.billingAddressId,
      this.shippingAddressId,
      this.addressesXml,
      this.genericAttributesXml,
      this.addressesList,
      this.genericAttributes,
      this.id});

  factory CustomerDetailDto.fromJson(String str) {
    return CustomerDetailDto.fromMap(json.decode(str));
  }

  static CustomerDto getProfileFromJson(String str) {
    var customer = CustomerDetailDto.fromJson(str);
    if (customer == null) return null;
    return customer.getProfile();
  }

  CustomerDto getProfile() {
    var myInfo = this;
    if (myInfo == null) return null;
    var profileInfo = CustomerDto(
        customerId: myInfo.id,
        firstName: myInfo?.genericAttributes?.genericAttribute
            ?.firstWhere((a) => a.key == 'FirstName', orElse: () => null)
            ?.value,
        lastName: myInfo?.genericAttributes?.genericAttribute
            ?.firstWhere((a) => a.key == 'LastName', orElse: () => null)
            ?.value,
        email: myInfo.email,
        phoneNumber: myInfo?.genericAttributes?.genericAttribute
            ?.firstWhere((a) => a.key == 'PhoneNumber', orElse: () => null)
            ?.value,
        imageUrl: myInfo?.genericAttributes?.genericAttribute
            ?.firstWhere((a) => a.key == 'ProfilePic', orElse: () => null)
            ?.value,
        billingAddressId: myInfo.billingAddressId,
        shippingAddressId: myInfo.shippingAddressId);
    if (profileInfo?.imageUrl != null &&
        profileInfo.imageUrl.contains(ApiRoutes.CdnPath) == false) {
      profileInfo.imageUrl = ApiRoutes.CdnPath + profileInfo.imageUrl;
    }
    return profileInfo;
  }

  String toJson() => json.encode(toMap());

  CustomerDetailDto.fromMap(Map<String, dynamic> json) {
    customerGuid = json['customerGuid'];
    username = json['username'];
    firstName = json['firstName'];
    phoneNumber = json['phoneNumber'];
    lastName = json['lastName'];
    email = json['email'];
    emailToRevalidate = json['emailToRevalidate'];
    adminComment = json['adminComment'];
    isTaxExempt = json['isTaxExempt'];
    affiliateId = json['affiliateId'] == null ? 0 : json['affiliateId'];
    vendorId = json['vendorId'] == null ? 0 : json['vendorId'];
    hasShoppingCartItems = json['hasShoppingCartItems'];
    requireReLogin = json['requireReLogin'];
    failedLoginAttempts =
        json['failedLoginAttempts'] == null ? 0 : json['failedLoginAttempts'];
    cannotLoginUntilDateUtc = json['cannotLoginUntilDateUtc'] == null
        ? null
        : DateTime.parse(json["cannotLoginUntilDateUtc"]);
    active = json['active'];
    deleted = json['deleted'];
    isSystemAccount = json['isSystemAccount'];
    systemName = json['systemName'];
    lastIpAddress = json['lastIpAddress'];
    createdOnUtc = json['createdOnUtc'] == null
        ? null
        : DateTime.parse(json["createdOnUtc"]);
    lastLoginDateUtc = json['lastLoginDateUtc'] == null
        ? null
        : DateTime.parse(json["lastLoginDateUtc"]);
    lastActivityDateUtc = json['lastActivityDateUtc'] == null
        ? null
        : DateTime.parse(json["lastActivityDateUtc"]);
    registeredInStoreId = json['registeredInStoreId'];
    billingAddressId =
        json['billingAddress_Id'] == null ? 0 : json['billingAddress_Id'];
    shippingAddressId =
        json['shippingAddress_Id'] == null ? 0 : json['shippingAddress_Id'];
    addressesXml = json['addressesXml'];
    genericAttributesXml = json['genericAttributesXml'];
    addressesList = json['addressesList'] != null
        ? new AddressesList.fromJson(json['addressesList'])
        : null;
    genericAttributes = json['genericAttributes'] != null
        ? new GenericAttributes.fromJson(json['genericAttributes'])
        : null;
    id = json['id'] == null ? 0 : json['id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerGuid'] = this.customerGuid;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['emailToRevalidate'] = this.emailToRevalidate;
    data['adminComment'] = this.adminComment;
    data['isTaxExempt'] = this.isTaxExempt;
    data['affiliateId'] = this.affiliateId;
    data['vendorId'] = this.vendorId;
    data['hasShoppingCartItems'] = this.hasShoppingCartItems;
    data['requireReLogin'] = this.requireReLogin;
    data['failedLoginAttempts'] = this.failedLoginAttempts;
    data['cannotLoginUntilDateUtc'] = this.cannotLoginUntilDateUtc == null
        ? null
        : this.cannotLoginUntilDateUtc.toIso8601String();
    data['active'] = this.active;
    data['deleted'] = this.deleted;
    data['isSystemAccount'] = this.isSystemAccount;
    data['systemName'] = this.systemName;
    data['lastIpAddress'] = this.lastIpAddress;
    data['createdOnUtc'] =
        this.createdOnUtc == null ? null : this.createdOnUtc.toIso8601String();
    data['lastLoginDateUtc'] = this.lastLoginDateUtc == null
        ? null
        : this.lastLoginDateUtc.toIso8601String();
    data['lastActivityDateUtc'] = this.lastActivityDateUtc == null
        ? null
        : this.lastActivityDateUtc.toIso8601String();
    data['registeredInStoreId'] = this.registeredInStoreId;
    data['billingAddressId'] = this.billingAddressId;
    data['shippingAddressId'] = this.shippingAddressId;
    data['addressesXml'] = this.addressesXml;
    data['genericAttributesXml'] = this.genericAttributesXml;
    if (this.addressesList != null) {
      data['addressesList'] = this.addressesList.toJson();
    }
    if (this.genericAttributes != null) {
      data['genericAttributes'] = this.genericAttributes.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class AddressesList {
  List<CustomerAddressDto> address;

  AddressesList({this.address});

  AddressesList.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = new List<CustomerAddressDto>();
      json['address'].forEach((v) {
        address.add(CustomerAddressDto.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class GenericAttributes {
  List<GenericAttribute> genericAttribute;

  GenericAttributes({this.genericAttribute});

  GenericAttributes.fromJson(Map<String, dynamic> json) {
    if (json['genericAttribute'] != null) {
      genericAttribute = new List<GenericAttribute>();
      json['genericAttribute'].forEach((v) {
        genericAttribute.add(new GenericAttribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genericAttribute != null) {
      data['genericAttribute'] =
          this.genericAttribute.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GenericAttribute {
  int entityId;
  String keyGroup;
  String key;
  String value;
  int storeId;
  int id;

  GenericAttribute(
      {this.entityId,
      this.keyGroup,
      this.key,
      this.value,
      this.storeId,
      this.id});

  GenericAttribute.fromJson(Map<String, dynamic> json) {
    entityId = json['entityId'] == null ? 0 : json['entityId'];
    keyGroup = json['keyGroup'];
    key = json['key'];
    value = json['value'];
    storeId = json['storeId'] == null ? 0 : json['storeId'];
    id = json['id'] == null ? 0 : json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entityId'] = this.entityId;
    data['keyGroup'] = this.keyGroup;
    data['key'] = this.key;
    data['value'] = this.value;
    data['storeId'] = this.storeId;
    data['id'] = this.id;
    return data;
  }
}
