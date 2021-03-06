import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/Screens/weeklyWeatherScreen.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';
import '../models/dailyWeather.dart';

class SevenDayForecast extends StatelessWidget {
  final wData;
  final List<DailyWeather> dWeather;

  SevenDayForecast({this.wData, this.dWeather});

  Widget dailyWidget(dynamic weather, BuildContext context) {
    final dayOfWeek = DateFormat('EEE').format(weather.date);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              dayOfWeek ?? '',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
            child:
                MapString.mapStringToIcon('${weather.condition}', context, 35),
          ),
          Text(
            '${weather.condition}',
          ),
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
          padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Row(
            children: [
              Text(
                'Next 7 Days',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(WeeklyScreen.routeName);
                },
                child: Text(
                  'See more',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4dabd5)),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(WeeklyScreen.routeName);
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(6, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          Temperature.getTemperatureCalUnit(
                              wData.weather.temp, wData.tempChoice),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: MapString.mapStringToIcon(
                              '${wData.weather.currently}', context, 45),
                        ),
                        MapString.mapInputToWeather(
                            '${wData.weather.currently}',
                            context,
                            15,
                            FontWeight.normal),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: dWeather
                            .map((item) => dailyWidget(item, context))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
