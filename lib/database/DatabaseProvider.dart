import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_weather/models/choice.dart';
import 'package:flutter_weather/models/city.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider dbProvider = DatabaseProvider._();
  static Database _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  static Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "citylist.db");

    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "citylist.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    var databaseData = await openDatabase(path, readOnly: false);

    return databaseData;
  }

  static Future<void> close() async {
    final db = await initDB();
    // final db = await database;
    return db.close();
  }

  static Future<List<City>> fetchWorldCities() async {
    final db = await initDB();
    // final db = await database;

    var result =
        await db.query("worldcities", columns: ['city'], distinct: true);
    List<City> list = result.isNotEmpty
        ? result.map<City>((e) => City.fromMap(e)).toList()
        : [];

    return list;
  }

  static Future<List<City>> fetchCity() async {
    final db = await initDB();
    // final db = await database;

    var result = await db.query("localcities");

    return List.generate(result.length, (i) {
      return City(
        cityName: result[i]['city'],
      );
    });
  }

  static Future<int> addCity(City city) async {
    final db = await initDB();
    // final db = await database;

    int result = await db.insert(
      'localcities',
      city.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  static Future<int> deleteCity(String cityName) async {
    final db = await initDB();
    // inal db = await database;

    int result = await db
        .delete('localcities', where: 'city = ?', whereArgs: [cityName]);

    return result;
  }

  static Future<Choice> fetchChoice() async {
    final db = await initDB();
    // final db = await database;

    var result = await db.query("choices");

    return result.isNotEmpty ? Choice.fromMap(result.first) : Null;
  }

  static Future<int> updateChoice(Choice choice) async {
    final db = await initDB();
    // final db = await database;

    var result = await db
        .update("choices", choice.toMap(), where: 'id = ?', whereArgs: [1]);

    return result;
  }
}
