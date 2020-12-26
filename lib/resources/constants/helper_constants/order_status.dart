import 'package:bluebellapp/resources/strings/general_string.dart';

class OrderStatus {
  /// <summary>
  /// Pending
  /// </summary>
  static const int Pending = 10,

      /// <summary>
      /// Processing
      /// </summary>
      Processing = 20,

      /// <summary>
      /// Complete
      /// </summary>
      Complete = 30,

      /// <summary>
      /// Cancelled
      /// </summary>
      Cancelled = 40;

  static String getName(int val) {
    return Pending == val
        ? GeneralStrings.ORDER_PENDING
        : Processing == val
            ? GeneralStrings.ORDER_PROCESSING
            : Complete == val
                ? GeneralStrings.ORDER_COMPLETE
                : Cancelled == val ? GeneralStrings.ORDER_CANCELLED : null;
  }
}
