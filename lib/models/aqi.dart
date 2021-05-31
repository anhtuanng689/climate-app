import 'package:flutter/cupertino.dart';

class Aqi with ChangeNotifier {
  var aqi;

  Aqi({this.aqi});

  factory Aqi.fromJson(Map<String, dynamic> json) {
    final aqiData = json['data']['current']['pollution']['aqius'];
    return Aqi(
      aqi: aqiData,
    );
  }
}
