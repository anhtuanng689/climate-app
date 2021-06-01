import 'package:flutter/material.dart';
import 'package:flutter_weather/helper/utils.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:intl/intl.dart';

class WeatherDetail extends StatelessWidget {
  final wData;

  WeatherDetail({this.wData});

  Widget _gridWeatherBuilder(String header, String body, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(6, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 5),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  header,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  body,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Today Details',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.375,
          width: MediaQuery.of(context).size.width,
          child: GridView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 2.25,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: [
              _gridWeatherBuilder('${wData.weather.humidity}%', 'Humidity',
                  WeatherIcons.wiRaindrop),
              _gridWeatherBuilder(
                  WindSpeed.getWindSpeedChoice(
                      wData.weather.windSpeed, wData.windSpeedChoice),
                  'Wind speed',
                  WeatherIcons.wiStrongWind),
              _gridWeatherBuilder(
                  Distance.getDistanceChoice(
                      wData.weather.visibility, wData.distanceChoice),
                  'Visibility',
                  WeatherIcons.wiSmallCraftAdvisory),
              _gridWeatherBuilder(
                  Pressure.getPressureChoice(
                      wData.weather.pressure, wData.pressureChoice),
                  'Pressure',
                  WeatherIcons.wiBarometer),
              _gridWeatherBuilder(
                  '0${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(wData.weather.sunrise * 1000))}',
                  'Sunrise',
                  WeatherIcons.wiSunrise),
              _gridWeatherBuilder(
                  '0${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(wData.weather.sunset * 1000))}',
                  'Sunset',
                  WeatherIcons.wiSunset),
            ],
          ),
        ),
      ],
    );
  }
}
