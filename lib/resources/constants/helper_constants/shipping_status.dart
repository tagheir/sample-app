import 'package:bluebellapp/resources/strings/general_string.dart';

class ShippingStatus {
  /// <summary>
  /// Shipping not required
  /// </summary>
  static const int ShippingNotRequired = 10,

      /// <summary>
      /// Not yet shipped
      /// </summary>
      NotYetShipped = 20,

      /// <summary>
      /// Partially shipped
      /// </summary>
      PartiallyShipped = 25,

      /// <summary>
      /// Shipped
      /// </summary>
      Shipped = 30,

      /// <summary>
      /// Delivered
      /// </summary>
      Delivered = 40;

  static String getName(int val) {
    return ShippingNotRequired == val
        ? GeneralStrings.SHIPPING_STATUS_SHIPPING_NOT_REQUIRED
        : NotYetShipped == val
            ? GeneralStrings.SHIPPING_STATUS_NOT_YET_SHIPPED
            : PartiallyShipped == val
                ? GeneralStrings.SHIPPING_STATUS_PARTIALLY_SHIPPED
                : Shipped == val
                    ? GeneralStrings.SHIPPING_STATUS_SHIPPED
                    : Delivered == val
                        ? GeneralStrings.SHIPPING_STATUS_DELIVERED
                        : null;
  }
}
