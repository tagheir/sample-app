import 'dart:convert';

class AddToCartDto {
  int productId;
  int shoppingCartTypeId = 1;
  int quantity = 1;
  int cartItemId;
  List<AttrMap> form = List<AttrMap>();
  DirectOrderProductAttribute directOrderProductAttribute =
      DirectOrderProductAttribute();

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
        "productId": this.productId,
        "shoppingCartTypeId": this.shoppingCartTypeId,
        "quantity": this.quantity,
        "cartItemId": this.cartItemId,
        "form": this.form
      };
}

class DirectOrderProductAttribute {
  double price;
  String dropDownAttributeValue;
  String dateAttributeValue;
  String pictureThumb;
  String name;
  int quantity;
  DirectOrderProductAttribute(
      {this.price,
      this.dropDownAttributeValue,
      this.pictureThumb,
      this.quantity,
      this.dateAttributeValue,
      this.name});
}

class AttrMap {
  String key;
  String value;

  AttrMap({this.key, this.value});

  AttrMap.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.key;
    data['Value'] = this.value;
    return data;
  }

  static String encodeList({List<AttrMap> attr}) {
    return json.encode(attr);
  }
}

// Map<String, dynamic> toJson(HashMap<String,String> hash) {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data[hash.keys[0]] = this.name;
//     data['Value'] = this.value;
//     return data;
//   }
