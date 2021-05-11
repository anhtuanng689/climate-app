import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';

class MainWeather extends StatelessWidget {
  final wData;
  final weatherData;

  MainWeather({this.wData, this.weatherData});

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 5),
      height: MediaQuery.of(context).size.height / 3.2,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
                        style: _style2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${wData.weather.cityName}',
                        style: _style1.copyWith(fontSize: 27),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Temperature.getTemperatureCalUnit(
                            wData.weather.temp, wData.tempChoice),
                        // '${wData.weather.temp.toStringAsFixed(0)}°C',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.arrow_upward),
                          Text(Temperature.getTemperature(
                              weatherData[0].tempMax, wData.tempChoice)),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_downward),
                          Text(Temperature.getTemperature(
                              weatherData[0].tempMin, wData.tempChoice)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Feels like ${Temperature.getTemperature(wData.weather.feelsLike, wData.tempChoice)}',
                        style: _style1.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 0,
                ),
                child: MapString.mapStringToIcon(
                    '${wData.weather.currently}', context, 90),
              ),
              SizedBox(height: 40),
              MapString.mapInputToWeather(
                  wData.weather.currently, context, 20, FontWeight.w600),
              // Text(
              //   toBeginningOfSentenceCase('${wData.weather.description}'),
              //   style: _style1.copyWith(fontSize: 19),
              // ),
              // Text(
              //   MapString.mapInputToWeather(wData.weather.currently, context),
              //   style: _style1.copyWith(fontSize: 20),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
