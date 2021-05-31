import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  var dailyTemp;
  var tempMax;
  var tempMin;
  var condition;
  var date;
  var precip;
  var uvi;

  DailyWeather({
    this.dailyTemp,
    this.tempMax,
    this.tempMin,
    this.condition,
    this.date,
    this.precip,
    this.uvi,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      precip: json['daily'][0]['pop'],
      uvi: json['daily'][0]['uvi'],
    );
  }

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      tempMax: json['temp']['max'],
      tempMin: json['temp']['min'],
      condition: json['weather'][0]['main'],
      precip: json['pop'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
    );
  }

  static DailyWeather fromHourlyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp'],
      condition: json['weather'][0]['main'],
      precip: json['pop'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
