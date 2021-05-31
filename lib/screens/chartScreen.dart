import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/weatherProvider.dart';

class ChartScreen extends StatelessWidget {
  static const routeName = '/chartScreen';

  final wData;

  ChartScreen({this.wData});

  Widget _gridAqiBuilder(String header, String body) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          Spacer(),
          FittedBox(
            child: RichText(
              text: TextSpan(
                text: body,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade900,
                    fontSize: 32),
                children: <TextSpan>[
                  TextSpan(
                    text: ' μg/m3',
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 15),
                  ),
                ],
              ),
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
            'Air quality',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: [
              _gridAqiBuilder(
                'CO',
                weatherData.aqiDetail.co.round().toString(),
              ),
              _gridAqiBuilder(
                'NO',
                weatherData.aqiDetail.no.round().toString(),
              ),
              _gridAqiBuilder(
                'NO2',
                weatherData.aqiDetail.no2.round().toString(),
              ),
              _gridAqiBuilder(
                'SO2',
                weatherData.aqiDetail.so2.round().toString(),
              ),
              _gridAqiBuilder(
                'O3',
                weatherData.aqiDetail.o3.round().toString(),
              ),
              _gridAqiBuilder(
                'NH3',
                weatherData.aqiDetail.nh3.round().toString(),
              ),
              _gridAqiBuilder(
                'PM2.5',
                weatherData.aqiDetail.pm2.round().toString(),
              ),
              _gridAqiBuilder(
                'PM10',
                weatherData.aqiDetail.pm10.round().toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
