import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_weather/models/chart.dart';

class HumidChart extends StatelessWidget {
  final String chartName;
  final String chartId;
  final chartColor;
  final chartType;
  final int max;
  final int min;
  final List<Chart> listData;
  HumidChart(
      {this.chartName,
      this.chartId,
      this.chartColor,
      this.max,
      this.min,
      this.listData,
      this.chartType});

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
                '$chartName',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
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
                id: chartId,
                colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
                domainFn: (Chart chart, _) => chart.time,
                measureFn: (Chart chart, _) => chart.humidity,
                measureUpperBoundFn: (Chart chart, _) => max,
                measureLowerBoundFn: (Chart chart, _) => min,
                data: listData,
              ),
            ],
            animate: true,
          ),

          // charts.TimeSeriesChart(
          //   [
          //     charts.Series<Chart, DateTime>(
          //       id: chartId,
          //       colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
          //       domainFn: (Chart chart, _) => chart.dateTime,
          //       measureFn: (Chart chart, _) => chart.humidity,
          //       measureUpperBoundFn: (Chart chart, _) => max,
          //       measureLowerBoundFn: (Chart chart, _) => min,
          //       data: listData,
          //     ),
          //   ],
          //   domainAxis: charts.EndPointsTimeAxisSpec(),
          //   dateTimeFactory: charts.LocalDateTimeFactory(),
          //   animate: true,
          // ),
          // charts.BarChart(
          //   [
          //     charts.Series<Chart, String>(
          //       id: chartId,
          //       colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
          //       domainFn: (Chart chart, _) => chart.time,
          //       measureFn: (Chart chart, _) => chart.humidity,
          //       measureUpperBoundFn: (Chart chart, _) => max,
          //       measureLowerBoundFn: (Chart chart, _) => min,
          //       data: listData,
          //     ),
          //   ],
          //   animate: true,
          // ),
        ),
      ],
    );
  }
}
