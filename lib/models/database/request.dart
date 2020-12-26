import 'dart:convert';

import 'package:flutter/material.dart';

class RequestDto {
  String name;
  String response;
  int age;
  int authorize;

  RequestDto({
    @required this.name,
    @required this.response,
    @required this.age,
    this.authorize = 0,
  });

  factory RequestDto.fromJson(String str) =>
      RequestDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RequestDto.fromMap(Map<String, dynamic> json) => RequestDto(
        name: json["name"] == null ? null : json["name"],
        response: json["response"] == null ? null : json["response"],
        age: json["age"] == null ? null : json["age"],
        authorize: json["authorize"] == null ? null : json["authorize"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "response": response == null ? null : response,
        "age": age == null ? null : age,
        "authorize": authorize == null ? null : authorize,
      };
  @override
  String toString() {
    return "Name => $name,\nResponse => $response";
  }

  String toStringCompact() {
    return "Name => $name, Authorize => ${authorize.toString()}, Age => ${age.toString()}";
  }
}
