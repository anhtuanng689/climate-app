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

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "citylist.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    var databaseData = await openDatabase(path, readOnly: false);

    return databaseData;

//     var databasesPath = await getDatabasesPath();
//     var path = join(databasesPath, "citylist.db");
//
// // Check if the database exists
//     var exists = await databaseExists(path);
//
//     if (!exists) {
//       // Should happen only the first time you launch your application
//       print("Creating new copy from asset");
//
//       // Make sure the parent directory exists
//       try {
//         await Directory(dirname(path)).create(recursive: true);
//       } catch (_) {}
//
//       // Copy from asset
//       ByteData data = await rootBundle.load(join("assets", "citylist.db"));
//       List<int> bytes =
//           data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//
//       // Write and flush the bytes written
//       await File(path).writeAsBytes(bytes, flush: true);
//     } else {
//       print("Opening existing database");
// open the database
//     await openDatabase(path, readOnly: false);
  }

  static Future<List<City>> fetchWorldCities() async {
    final database = await initDB();

    var result = await database.query("worldcities", columns: ['city']);
    List<City> list = result.isNotEmpty
        ? result.map<City>((e) => City.fromMap(e)).toList()
        : [];
    return list;
  }

  static Future<List<City>> fetchCity() async {
    final database = await initDB();
    var result = await database.query("localcities");

    return List.generate(result.length, (i) {
      return City(
        cityName: result[i]['city'],
      );
    });
  }

  static Future<int> addCity(City city) async {
    final database = await initDB();
    int result = await database.insert(
      'localcities',
      city.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(result);
    return result;
  }

  static Future<int> deleteCity(String cityName) async {
    final database = await initDB();
    int result = await database
        .delete('localcities', where: 'city = ?', whereArgs: [cityName]);
    print(result);
    return result;
  }

  static Future<void> close() async {
    final database = await initDB();
    return database.close();
  }

  static Future<Choice> fetchChoice() async {
    final database = await initDB();
    var result = await database.query("choices");

    return result.isNotEmpty ? Choice.fromMap(result.first) : Null;
  }

  static Future<int> updateChoice(Choice choice) async {
    final database = await initDB();
    var result = await database
        .update("choices", choice.toMap(), where: 'id = ?', whereArgs: [1]);
    print(result);
    return result;
  }
}
