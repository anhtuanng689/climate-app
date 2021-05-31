import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_weather/models/chart.dart';
import 'package:flutter_weather/screens/chartScreen.dart';

class WeatherBarChart extends StatelessWidget {
  final wData;
  WeatherBarChart({this.wData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            children: [
              Text(
                'Precipitation Chart',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ChartScreen.routeName);
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
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: charts.BarChart(
            [
              charts.Series<Chart, String>(
                id: 'Prep',
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (Chart chart, _) => chart.time,
                measureFn: (Chart chart, _) => chart.percent,
                measureUpperBoundFn: (Chart chart, _) => 100,
                measureLowerBoundFn: (Chart chart, _) => 0,
                data: wData.listPrepChart,
              )
            ],
            animate: true,
          ),
        ),
      ],
    );
  }
}
