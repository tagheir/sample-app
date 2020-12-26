import 'package:meta/meta.dart';
import 'dart:convert';

class CreateOrderResponseDto {
    List<String> warning;
    int orderId;

    CreateOrderResponseDto({
        @required this.warning,
        @required this.orderId,
    });

    factory CreateOrderResponseDto.fromJson(String str) => CreateOrderResponseDto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CreateOrderResponseDto.fromMap(Map<String, dynamic> json) => CreateOrderResponseDto(
        warning: json["warning"] == null ? List<String>() : List<String>.from(json["warning"].map((x) => x)),
        orderId: json["orderId"] == null ? 0 : json["orderId"],
    );

    Map<String, dynamic> toMap() => {
        "warning": warning == null ? null : List<String>.from(warning.map((x) => x)),
        "orderId": orderId == null ? null : orderId,
    };
}
