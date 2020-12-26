import 'package:bluebellapp/models/database/request.dart';
import 'package:bluebellapp/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseNetworkTableService {
  static const String TABLE_NAME = "network";

  static Future<void> insert(RequestDto requestDto) async {
    final Database db = await DatabaseService.database;
    var dto = await get(requestDto.name, requestDto.authorize ?? 0);
    if (dto != null) {
      await delete(dto.name);
    }
    await db.insert(
      TABLE_NAME,
      requestDto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> printAuthorized() async {
    final Database db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_NAME, where: "authorize = ?", whereArgs: [1]);
    if (maps == null || maps.length == 0) {
      print("EMPTY AUTHORIZE NETWORK");
      return Future.value(null);
    } else {
      for (var map in maps) {
        var item = RequestDto.fromMap(map);
        print(item.toStringCompact());
      }
    }
  }

  static Future<RequestDto> get(String name, int authorize) async {
    final Database db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME,
        where: "name = ? and authorize = ?", whereArgs: [name, authorize]);
    if (maps == null || maps.length == 0) {
      return Future.value(null);
    }
    var map = maps.first;
    return RequestDto.fromMap(map);
  }

  static Future<void> clearAuthorized() async {
    final Database db = await DatabaseService.database;
    var deletionCount =
        await db.delete(TABLE_NAME, where: "authorize = ?", whereArgs: [1]);
    print("Deleted Rows => ${deletionCount.toString()}");
    printAuthorized().then((value) => null);
  }

  static Future<void> delete(String name) async {
    final Database db = await DatabaseService.database;
    await db.delete(TABLE_NAME, where: "name = ?", whereArgs: [name]);
  }
}
