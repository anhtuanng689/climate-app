import 'package:intl/intl.dart';

class Chart {
  final String time;
  final DateTime dateTime;
  final int prep;
  final int humidity;
  final int uvi;
  final int windSpeed;
  final int dewPoint;

  Chart(
      {this.uvi,
      this.windSpeed,
      this.dewPoint,
      this.humidity,
      this.time,
      this.prep,
      this.dateTime});

  factory Chart.fromMap(Map<String, dynamic> json) => Chart(
        time: DateFormat.j()
            .format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
        prep: (json['pop'] * 100).toInt(),
        humidity: json['humidity'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        uvi: json['uvi'].round().toInt(),
        windSpeed: (json['wind_speed'] * 3.6).round().toInt(),
        dewPoint: json['dew_point'].round().toInt(),
      );
}
