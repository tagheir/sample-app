import 'dart:convert';

import 'package:flutter/widgets.dart';

class BannerDto {
  String title;
  String bannerUrl;
  String seName;

  BannerDto({
    @required this.title,
    @required this.seName,
    this.bannerUrl,
  });

  factory BannerDto.fromJson(String str) => BannerDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerDto.fromMap(Map<String, dynamic> json) => BannerDto(
        title: json["title"] == null ? null : json["title"],
        seName: json["seName"] == null ? null : json["seName"],
        bannerUrl: json["bannerUrl"] == null ? null : json["bannerUrl"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "seName": seName == null ? null : seName,
        "bannerUrl": bannerUrl == null ? null : bannerUrl,
      };
}
