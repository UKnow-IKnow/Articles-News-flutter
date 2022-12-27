import 'package:hive_flutter/hive_flutter.dart';

class AppHiveDb {
  static String dbName = "myHivedb";

  static Future<dynamic> setData(dynamic data) async {
    try {
      Box box = await Hive.openBox(dbName);

      box.add(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> getAllData() async {
    try {
      Box box = await Hive.openBox(dbName);
      return box.values.toList();
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> clearData() async {
    try {
      Box box = await Hive.openBox(dbName);
      box.deleteAt(0);

      return true;
    } catch (e) {
      return false;
    }
  }
}
