class ParentDto {
  String key;
  String value;

  ParentDto({this.key, this.value});

  ParentDto.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.key;
    data['Value'] = this.value;
    return data;
  }

  static List<ParentDto> fromMapList(Iterable<dynamic> json) {
    return List<ParentDto>.from(
        json.map((x) => ParentDto.fromJson(x)));
  }
}