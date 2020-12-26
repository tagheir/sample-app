import 'dart:convert';
import 'package:bluebellapp/models/landscape_project_dto.dart';
import 'package:bluebellapp/models/productDetail_dto.dart';

class LandscapeServiceDetailDto {
  ProductDetailDto productDetailDto;
  List<LandscapeProjectDto> landscapeProjects;
  LandscapeServiceDetailDto({this.landscapeProjects, this.productDetailDto});

  factory LandscapeServiceDetailDto.fromJson(String str) {
    return LandscapeServiceDetailDto.fromMap(json.decode(str));
  }

  LandscapeServiceDetailDto.fromMap(Map<String, dynamic> json) {
    productDetailDto = json['productDetailViewResponse'] == null
        ? ProductDetailDto()
        : ProductDetailDto.fromMap(json['productDetailViewResponse']);
    //////print(json);
    landscapeProjects = json['projectDetails'] == null
        ? List<LandscapeProjectDto>()
        : LandscapeProjectDto.fromMapList(list: json['projectDetails']);
  }

  setImagesPath() async {
    await productDetailDto.setProductImagePath();
    landscapeProjects =
        await LandscapeProjectDto.setProjectsImagesPath(landscapeProjects);
  }
}
