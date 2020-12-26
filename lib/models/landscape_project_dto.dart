import 'dart:convert';

import 'package:bluebellapp/services/local_images_service.dart';

class LandscapeProjectDto {
  int id;
  String name;
  String address;
  List<String> picturePathWithCdn;
  String categoryName;
  String categorySlug;

  LandscapeProjectDto(
      {this.id,
      this.name,
      this.address,
      this.picturePathWithCdn,
      this.categoryName,
      this.categorySlug});

  factory LandscapeProjectDto.fromJson(String str) {
    return LandscapeProjectDto.fromMap(json.decode(str));
  }

  static List<LandscapeProjectDto> fromMapList(
      {String str, Iterable<dynamic> list}) {
    var jsonList;
    if (str != null) {
      jsonList = json.decode(str) as Iterable<dynamic>;
    } else {
      jsonList = list;
    }
    return List<LandscapeProjectDto>.from(
        jsonList.map((x) => LandscapeProjectDto.fromMap(x)));
  }

  LandscapeProjectDto.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    picturePathWithCdn = json['picturePathWithCdn'].cast<String>();
    categoryName = json['categoryName'];
    categorySlug = json['categorySlug'];
  }

  static Future<List<LandscapeProjectDto>> setProjectsImagesPath(
      List<LandscapeProjectDto> projects) async {
    if (projects != null) {
      for (var project in projects) {
        for (var picture in project.picturePathWithCdn) {
          picture =
              await LocalImageService.getLocalImagePath(picture) ?? picture;
        }
      }
      return Future.value(projects);
    }
    return List<LandscapeProjectDto>();
  }

  setProjectImagesPath() async {
    for (var picture in picturePathWithCdn) {
      picture = await LocalImageService.getLocalImagePath(picture) ?? picture;
    }
  }
}
