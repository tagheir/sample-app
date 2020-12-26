enum TemplateType {
  Default,
  Product,
  Landscape,
  FacilitiesManagement,
  MaintenancePackage,
  Simple
}

extension TemplateTypeExtensions on TemplateType {
  bool isService() =>
      this == TemplateType.FacilitiesManagement ||
      this == TemplateType.Landscape;

  bool isFacilitiesManagementService() =>
      this == TemplateType.FacilitiesManagement;

  bool isProduct() =>
      this == TemplateType.Default ||
      this == TemplateType.Product ||
      this == TemplateType.Simple;

  bool isMaintenancePackage() => this == TemplateType.MaintenancePackage;
  // ||
  // this == TemplateType.Simple ||
  // this == TemplateType.Default;
}

class TemplateTypeHelper {
  static const String DefaultCategory =
          'CategoryTemplate.ProductsInGridOrLines',
      LandscapeCategory = 'CategoryTemplate.LandscapeService',
      FacilitiesManagementCategory =
          'CategoryTemplate.FacilitiesManagementService',
      MaintenancePackageCategory = 'CategoryTemplate.Packages';

  static const String SimpleProduct = "ProductTemplate.Simple";
  static const String GroupedProduct = "ProductTemplate.Grouped";
  static const String LandscapeProduct = "ProductTemplate.LandscapeService";
  static const String FacilitiesManagementProduct =
      "ProductTemplate.FacilitiesManagementService";
  static const String PackageProduct = "ProductTemplate.Package";

  static TemplateType getTemplateTypeOfProduct(String templatePath) {
    switch (templatePath) {
      case LandscapeProduct:
        return TemplateType.Landscape;
      case FacilitiesManagementProduct:
        return TemplateType.FacilitiesManagement;
      case PackageProduct:
        return TemplateType.MaintenancePackage;
      case SimpleProduct:
        return TemplateType.Product;
      default:
        return TemplateType.Simple;
    }
  }

  static TemplateType getTemplateTypeOfCategory(String templatePath) {
    switch (templatePath) {
      case LandscapeCategory:
        return TemplateType.Landscape;
      case FacilitiesManagementCategory:
        return TemplateType.FacilitiesManagement;
      case MaintenancePackageCategory:
        return TemplateType.MaintenancePackage;
      case DefaultCategory:
        return TemplateType.Product;
      default:
        return TemplateType.Product;
    }
  }
}
