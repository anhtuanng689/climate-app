import 'package:flutter/cupertino.dart';

class City with ChangeNotifier {
  String city;
  String country;

  City({this.city, this.country});

  factory City.fromMap(Map<String, dynamic> json) => new City(
        city: json["city"] as String,
        country: json["country"] as String,
      );
}
