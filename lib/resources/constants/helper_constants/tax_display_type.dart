class TaxDisplayType {
  /// <summary>
  /// Including tax
  /// </summary>
  static const int IncludingTax = 0,

      /// <summary>
      /// Excluding tax
      /// </summary>
      ExcludingTax = 10;
  static String getName(int val) {
    return IncludingTax == val
        ? "IncludingTax"
        : ExcludingTax == val ? "ExcludingTax" : null;
  }
}
