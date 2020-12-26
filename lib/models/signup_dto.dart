import 'dart:convert';

class SignUpDto{
  String email;
  String password;
  String firstName;
  String lastName;
  String phoneNumber;

  SignUpDto({this.email,this.password,this.firstName,this.lastName,this.phoneNumber});

  // factory SignUpDto.fromJson(String str) =>
  //     SignUpDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}