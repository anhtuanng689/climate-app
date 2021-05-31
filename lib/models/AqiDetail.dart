import 'package:flutter/cupertino.dart';

class AqiDetail with ChangeNotifier {
  var pm2;
  var pm10;
  var no2;
  var so2;
  var co;
  var o3;
  var no;
  var nh3;

  AqiDetail(
      {this.pm2,
      this.pm10,
      this.no2,
      this.so2,
      this.co,
      this.o3,
      this.nh3,
      this.no});

  factory AqiDetail.fromJson(Map<String, dynamic> json) {
    final aqiData = json['list'][0]['components'];
    return AqiDetail(
      pm2: aqiData['pm2_5'],
      pm10: aqiData['pm10'],
      no2: aqiData['no2'],
      so2: aqiData['so2'],
      co: aqiData['co'],
      o3: aqiData['o3'],
      no: aqiData['no'],
      nh3: aqiData['nh3'],
    );
  }
}
