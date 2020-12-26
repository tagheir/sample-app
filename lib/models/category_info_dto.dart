import 'package:bluebellapp/models/banner_dto.dart';

class CategoryInfoDto extends BannerDto {
  CategoryInfoDto(
      {String description,
      String templateTypeName,
      String backgroundUrl,
      String title,
      String bannerUrl,
      String seName})
      : super(title: title, bannerUrl: bannerUrl, seName: seName) {
    this.description = description;
    this.templateTypeName = templateTypeName;
    this.backgroundUrl = backgroundUrl;
  }

  // CategoryInfoDto(
  //     {this.templateTypeName, this.description, this.backgroundUrl});
  String description;
  String templateTypeName;
  String backgroundUrl;

  CategoryInfoDto.fromMap(Map<String, dynamic> json) {
    title = json["title"] == null ? null : json["title"];
    bannerUrl = json["bannerUrl"] == null ? null : json["bannerUrl"];
    seName = json["seName"] == null ? null : json["seName"];
    description = json["description"] == null ? null : json["description"];
    backgroundUrl =
        json["backgroundUrl"] == null ? null : json["backgroundUrl"];
    templateTypeName =
        json["templateTypeName"] == null ? null : json["templateTypeName"];
  }
}

enum CategoryType { Store, Landscape, FacilityManagement, MaintainancePackage }
