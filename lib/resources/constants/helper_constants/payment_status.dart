import 'package:bluebellapp/resources/strings/general_string.dart';

class PaymentStatus {
  /// <summary>
  /// Pending
  /// </summary>
  static const int Pending = 10,

      /// <summary>
      /// Authorized
      /// </summary>
      Authorized = 20,

      /// <summary>
      /// Paid
      /// </summary>
      Paid = 30,

      /// <summary>
      /// Partially Refunded
      /// </summary>
      PartiallyRefunded = 35,

      /// <summary>
      /// Refunded
      /// </summary>
      Refunded = 40,

      /// <summary>
      /// Voided
      /// </summary>
      Voided = 50;

  static String getName(int val) {
    return Pending == val
        ? GeneralStrings.PAYMENT_PENDING
        : Authorized == val
            ? GeneralStrings.PAYMENT_AUTHORIZED
            : Paid == val
                ? GeneralStrings.PAYMENT_PAID
                : PartiallyRefunded == val
                    ? GeneralStrings.PAYMENT_PARTIALLY_REFUNDED
                    : Refunded == val
                        ? GeneralStrings.PAYMENT_REFUNDED
                        : Voided == val ? GeneralStrings.PAYMENT_VOIDED : null;
  }
}
