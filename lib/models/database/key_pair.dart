import 'dart:convert';

import 'package:flutter/material.dart';

class KeyPairDto {
  String key;
  String value;

  KeyPairDto({@required this.key, @required this.value});

  factory KeyPairDto.fromJson(String str) =>
      KeyPairDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KeyPairDto.fromMap(Map<String, dynamic> json) => KeyPairDto(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}
