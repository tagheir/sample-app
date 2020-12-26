import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Future<Database> database;

  static const int VERSION = 3;
  static const String DATABASE_NAME = "sys_bb.db";
  static const String CREATE_REQUEST_TABLE =
      "CREATE TABLE network(name TEXT PRIMARY KEY, response TEXT, authorize INTEGER default 0, age INTEGER)";

  static const String CREATE_KEY_VALUE_TABLE =
      "CREATE TABLE key_value(key TEXT PRIMARY KEY, value TEXT)";

  static Future<void> upgradeDatabase(db, oldVersion, newVersion) async {
    ////print("=======DatabaseService.CREATE_KEY_VALUE_TABLE=======");
    if (oldVersion < 2 && newVersion >= 2) {
      ////print("=======DatabaseService.CREATE_KEY_VALUE_TABLE=======");
      await db.execute(DatabaseService.CREATE_KEY_VALUE_TABLE);
    }
    if (oldVersion < 3 && newVersion >= 3) {
      ////print("=======DatabaseService.CREATE_KEY_VALUE_TABLE=======");
      var query = "ALTER TABLE network ADD COLUMN authorize INTEGER  default 0";
      //print(query);
      await db.execute(query);
    }
    return Future.value(null);
  }

  static Future<void> createDatabase(db, version) async {
    //print("=======DatabaseService.CREATE=======");
    await db.execute(DatabaseService.CREATE_KEY_VALUE_TABLE);
    return await db.execute(DatabaseService.CREATE_REQUEST_TABLE);
  }
}
