import 'dart:convert';
import 'package:bluebellapp/models/parent_dto.dart';
import 'package:bluebellapp/models/product_dto.dart';
import 'package:bluebellapp/resources/constants/api_routes.dart';
import 'package:bluebellapp/resources/constants/helper_constants/template_type.dart';

class CategoryDto {
  int id;
  String name;
  String description;
  bool showOnHomepage;
  int displayOrder;
  String pictureThumbPath;
  String picturePath;
  String templateTypeName;
  List<ParentDto> parents;
  List<ProductDto> products;
  List<CategoryDto> subCategories;
  TemplateType templateType;

  CategoryDto(
      {this.id,
      this.name,
      this.showOnHomepage,
      this.displayOrder,
      this.pictureThumbPath,
      this.templateTypeName,
      this.parents,
      this.subCategories,
      this.templateType,
      this.picturePath,
      this.description,
      this.products});

  factory CategoryDto.fromJson(String str) {
    return CategoryDto.fromMap(json.decode(str));
  }
  static List<CategoryDto> fromMapList(Iterable<dynamic> json) {
    return List<CategoryDto>.from(json.map((x) => CategoryDto.fromMap(x)));
  }
  //String toJson() => json.encode(toMap());

  CategoryDto.fromMap(Map<String, dynamic> json) {
    id = json['id'] == null ? 0 : json['id'];
    name = json['name'];
    description = json['description'];
    showOnHomepage = json['showOnHomePage'];
    displayOrder = json['displayOrder'];
    pictureThumbPath = json['pictureThumbPath'] == null
        ? null
        : ApiRoutes.CdnPath + json['pictureThumbPath'];
    picturePath = json['picturePath'] == null
        ? null
        : ApiRoutes.CdnPath + json['picturePath'];
    templateTypeName = json['templateName'];
    products = json['products'] == null
        ? List<ProductDto>()
        : ProductDto.fromMapList(json['products']);
    parents = json['parents'] == null
        ? List<ParentDto>()
        : ParentDto.fromMapList(json['parents']);
    subCategories = json['subCategories'] == null
        ? List<CategoryDto>()
        : CategoryDto.fromMapList(json['subCategories']);
    // templateType = templateTypeName == null
    //     ? ''
    //     : TemplateTypeHelper.getTemplateTypeOfProduct(templateTypeName);
  }
}
