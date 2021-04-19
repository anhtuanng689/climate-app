import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_weather/models/city.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider dbProvider = DatabaseProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "citylist.db");

    await deleteDatabase(dbPath);

    ByteData data = await rootBundle.load("assets/database/citylist.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    return await openDatabase(dbPath);
  }

  // Future<List<Logo>> getCategories() async {
  //   Database database = await this.database;
  //   var result = await database.query(
  //     'logotable',
  //     columns: ['categories', 'cat_id'],
  //     distinct: true,
  //   );
  //
  //   List<Logo> list =
  //   result.isNotEmpty ? result.map((e) => Logo.fromMap(e)).toList() : [];
  //   return list;
  // }

  static Future<List<City>> loadCities() async {
    var database = await initDB();
    var result = await database.query("worldcities", columns: ['city']);
    List<City> list = result.isNotEmpty
        ? result.map<City>((e) => City.fromMap(e)).toList()
        : [];
    print(list[0]);
    print(list[0].city);
    return list;
  }
}
