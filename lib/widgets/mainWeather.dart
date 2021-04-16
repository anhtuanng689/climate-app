import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';

class MainWeather extends StatelessWidget {
  final wData;

  MainWeather({this.wData});

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
      height: MediaQuery.of(context).size.height / 3,
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
                  // RotatedBox(
                  //   quarterTurns: 1,
                  //   child: Text(
                  //     toBeginningOfSentenceCase('${wData.weather.currently}'),
                  //     style: _style1.copyWith(fontSize: 20),
                  //   ),
                  // ),
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
                        '${wData.weather.temp.toStringAsFixed(0)}°C',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.arrow_upward),
                          Text('${wData.weather.tempMax.toStringAsFixed(0)}°'),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_downward),
                          Text('${wData.weather.tempMin.toStringAsFixed(0)}°'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Feels like ${wData.weather.feelsLike.toStringAsFixed(0)}°',
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
              MapString.mapStringToIcon(
                  '${wData.weather.currently}', context, 90),
              SizedBox(height: 30),
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
