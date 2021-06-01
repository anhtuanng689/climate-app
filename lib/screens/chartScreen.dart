import 'package:flutter/material.dart';
import 'package:flutter_weather/widgets/dewPointChart.dart';
import 'package:flutter_weather/widgets/humidChart.dart';
import 'package:flutter_weather/widgets/prepChart.dart';
import 'package:flutter_weather/widgets/uvChart.dart';
import 'package:flutter_weather/widgets/windSpeedChart.dart';
import 'package:provider/provider.dart';

import '../provider/weatherProvider.dart';

class ChartScreen extends StatelessWidget {
  static const routeName = '/chartScreen';

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
            'Charts',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              PrepChart(
                listData: weatherData.listChart,
                chartId: 'Precipitation',
                chartName: 'Precipitation (%)',
                max: 100,
                min: 0,
                isHome: false,
              ),
              HumidChart(
                listData: weatherData.listChart,
                chartId: 'Humidity',
                chartName: 'Humidity (%)',
                max: 100,
                min: 0,
              ),
              UVChart(
                listData: weatherData.listChart,
                chartId: 'UV Index',
                chartName: 'UV Index',
                max: 12,
                min: 0,
              ),
              WindSpeedChart(
                listData: weatherData.listChart,
                chartId: 'Wind Speed',
                chartName: 'Wind Speed (km/h)',
                max: 24,
                min: 0,
              ),
              DewPointChart(
                listData: weatherData.listChart,
                chartId: 'Dew Point',
                chartName: 'Dew Point (°C)',
                max: 27,
                min: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
