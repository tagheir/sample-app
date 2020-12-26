import 'package:bluebellapp/models/database/key_pair.dart';
import 'package:bluebellapp/services/database/database_key_value_table_service%20copy.dart';

class LocalStorageService {
  //static var storage = FlutterSecureStorage();

  static Future<bool> save(String key, String value) async {
    var dto = KeyPairDto(key: key, value: value);
    ////print("key===" + key);
    if (value == null) {
      ////print("value====" + value);
    } else {
      ////print("value==== NULL");
    }
    await DatabaseKeyValueTableService.insert(dto);
    return true;
  }

  static Future<String> get(String key) async {
    var dto = await DatabaseKeyValueTableService.get(key);
    //////print("from db");
    //////print(dto?.value);
    return Future.value(dto?.value);
  }

  static Future<void> delete(String key) async {
    await DatabaseKeyValueTableService.delete(key);
  }

  static Future<void> clear() async {
    await DatabaseKeyValueTableService.clear();
  }
}
