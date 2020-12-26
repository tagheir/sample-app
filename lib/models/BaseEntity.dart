
abstract class BaseEntity{
    BaseEntity fromJson(String str);
    BaseEntity fromMap(Map<String,dynamic> map);
    String toJson(BaseEntity dto);
    Map<String,dynamic> toMap(BaseEntity dto);
}