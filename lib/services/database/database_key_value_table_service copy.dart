import 'package:bluebellapp/models/database/key_pair.dart';
import 'package:bluebellapp/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseKeyValueTableService {
  static const String TABLE_NAME = "key_value";

  static Future<void> insert(KeyPairDto dto) async {
    final Database db = await DatabaseService.database;
    await db.insert(
      TABLE_NAME,
      dto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<KeyPairDto> get(String key) async {
    final Database db = await DatabaseService.database;
    List<Map<String, dynamic>> maps;
    try {
      maps = await db.query(TABLE_NAME, where: "key = ?", whereArgs: [key]);
    } catch (e) {}
    if (maps == null || maps.length == 0) {
      return Future.value(null);
    }

    var map = maps.first;
    return KeyPairDto.fromMap(map);
  }

  static Future<void> delete(String key) async {
    final Database db = await DatabaseService.database;
    await db.delete(TABLE_NAME, where: "key = ?", whereArgs: [key]);
  }

  static Future<void> clear() async {
    final Database db = await DatabaseService.database;
    await db.delete(TABLE_NAME);
  }
}
