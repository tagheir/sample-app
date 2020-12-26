enum AddressType { None, BillingAddress, ShippingAddress }

extension AddressTypeExtension on AddressType {
  String get value {
    switch (this) {
      case AddressType.ShippingAddress:
        return "3";
      case AddressType.BillingAddress:
        return "2";
      default:
        return null;
    }
  }
}
