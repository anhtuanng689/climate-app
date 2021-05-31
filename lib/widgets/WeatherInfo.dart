import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

import '../helper/utils.dart';

class WeatherInfo extends StatelessWidget {
  final wData;
  WeatherInfo({this.wData});

  Widget _weatherInfoBuilder(String header, String body, IconData icon,
      double rightPad, double iconSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15, right: rightPad),
            child: Icon(
              icon,
              color: Colors.blue,
              size: iconSize,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  header,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
              FittedBox(
                child: Text(
                  body,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: MediaQuery.of(context).size.height / 7,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(6, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.3,
              child: _weatherInfoBuilder(
                'Precipitation',
                '${(((wData.precip * 100 / 10).round()) * 10)}%',
                WeatherIcons.wiRaindrops,
                0,
                50,
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 2.3,
              child: _weatherInfoBuilder(
                'UV Index',
                UvIndex.mapUviValueToString(uvi: wData.uvi),
                WeatherIcons.wiDaySunny,
                15,
                30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
