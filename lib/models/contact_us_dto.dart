import 'dart:convert';

class ContactUsDto {
  String name;
  String emailAddress;
  String phoneNumber;
  String area;
  String address;
  String message;
  String subject;
  ContactUsDto(
      {this.name,
      this.emailAddress,
      this.phoneNumber,
      this.subject,
      this.area,
      this.address,
      this.message});
  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['emailAddress'] = this.emailAddress;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['area'] = this.area;
    data['address'] = this.address;
    return data;
  }
}
