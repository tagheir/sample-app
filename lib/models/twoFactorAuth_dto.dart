import 'dart:convert';

class TwoFactorAuthDto {
  String userVerificationToken;
  String emailOrPhoneNumber;
  String code;
  TwoFactorAuthDto({this.userVerificationToken, this.emailOrPhoneNumber, this.code});
  factory TwoFactorAuthDto.fromJson(String str) =>
      TwoFactorAuthDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userVerificationToken'] = this.userVerificationToken;
    data['emailOrPhoneNumber'] = this.emailOrPhoneNumber;
    data['code'] = this.code;
    return data;
  }

  factory TwoFactorAuthDto.fromMap(Map<String, dynamic> json) {
    var response = TwoFactorAuthDto(
      userVerificationToken: json["userVerificationToken"] == null
          ? null
          : json["userVerificationToken"],
      emailOrPhoneNumber: json["emailOrPhoneNumber"] == null ? null : json["emailOrPhoneNumber"],
      code: json["code"] == null ? null : json["code"],
    );
    return response;
  }
}
