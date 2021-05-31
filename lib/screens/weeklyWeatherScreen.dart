import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import '../provider/weatherProvider.dart';

class WeeklyScreen extends StatelessWidget {
  static const routeName = '/weeklyScreen';

  Widget dailyWidget(dynamic weather, dynamic wData, BuildContext context) {
    final dayOfWeek = DateFormat('EEEEE').format(weather.date);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  dayOfWeek ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.175,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: MapString.mapStringToIcon(weather.condition,
                          context, MediaQuery.of(context).size.width * 0.06),
                    ),
                    if ((((weather.precip * 100 / 10).round()) * 10) >= 20)
                      Text(
                        '${(((weather.precip * 100 / 10).round()) * 10).toString()}%',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue),
                      ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 15),
              //   child:
              //       MapString.mapStringToIcon(weather.condition, context, 25),
              // ),
              Spacer(),
              Text(
                Temperature.getTemperatureWithoutPoint(
                    weather.tempMax, wData.tempChoice),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text('/',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  )),
              Text(
                Temperature.getTemperatureWithoutPoint(
                    weather.tempMin, wData.tempChoice),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Divider(color: Colors.black),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Next 7 Days',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: Column(
            children: weatherData.sevenDayWeather
                .map((item) => dailyWidget(item, weatherData, context))
                .toList(),
          ),
        ),
      ),
    );
  }
}
