import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import '../provider/weatherProvider.dart';

class HourlyScreen extends StatelessWidget {
  static const routeName = '/hourlyScreen';

  Widget dailyWidget(dynamic weather, dynamic wData, BuildContext context) {
    final time = weather.date;
    final hours = DateFormat.Hm().format(time);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(2, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            hours ?? '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
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
                  child: MapString.mapStringToIcon(weather.condition, context,
                      MediaQuery.of(context).size.width * 0.06),
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
          Spacer(),
          Text(
            Temperature.getTemperature(weather.dailyTemp, wData.tempChoice),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
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
            'Next 24 Hours',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: ListView(
            children: weatherData.hourly24Weather
                .map((item) => dailyWidget(item, weatherData, context))
                .toList(),
          ),
        ),
      ),
    );
  }
}
