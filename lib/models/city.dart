import 'package:flutter/cupertino.dart';

class City with ChangeNotifier {
  String cityName;

  City({this.cityName});

  factory City.fromMap(Map<String, dynamic> json) => new City(
        cityName: json["city"] as String,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "city": cityName,
    };
  }
}
