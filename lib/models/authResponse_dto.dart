import 'dart:convert';
import 'dart:core';

class AuthenticationResult {
  String token;
  String refreshToken;
  String role;
  bool status;
  bool codeStatus;
  bool tokenStatus;
  List<String> errors;

  AuthenticationResult({
    this.token,
    this.role,
    this.refreshToken,
    this.status,
    this.codeStatus,
    this.errors,
    this.tokenStatus,
  });

  factory AuthenticationResult.fromJson(String str) =>
      AuthenticationResult.fromMap(json.decode(str));

  factory AuthenticationResult.fromMap(Map<String, dynamic> json) {
    var parsedErrors = json["errors"] == null
        ? List<String>()
        : (json["errors"] as List<dynamic>).map((f) => f.toString()).toList();
    var response = AuthenticationResult(
        token: json["token"] == null ? null : json["token"],
        refreshToken:
            json["refreshToken"] == null ? null : json["refreshToken"],
        status: json["status"] == null ? false : json["status"],
        codeStatus: json["codeStatus"] == null ? false : json["codeStatus"],
        tokenStatus: json["tokenStatus"] == null ? false : json["tokenStatus"],
        errors: parsedErrors);
    response.errors = parsedErrors;
    return response;
  }
}
