import 'package:climate_app/model/WeatherModel.dart';
import 'package:climate_app/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({
    Key key,
    @required this.futureLocationWeather,
    this.listFutureLocationWeather,
  }) : super(key: key);

  final Future<Weather> futureLocationWeather;
  final Future<List<Weather>> listFutureLocationWeather;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: SizeConfig.screenHeight * 1.8,
        width: SizeConfig.screenWidth,
        child: FutureBuilder(
            future: futureLocationWeather,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                Weather data = snapshot.data;
                print(DateFormat.yMMMd().format(
                    DateTime.fromMillisecondsSinceEpoch(data.time * 1000)));

                return Container(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2.5),
                  child: Column(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(data.time * 1000))}',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Text(
                                  '${data.cityName}',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 7.5),
                                ),
                              ],
                            ),
                            Container(
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  '${data.main}',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.45,
                        width: SizeConfig.screenWidth,
                        child: Icon(
                          data.getIconData(),
                          size: SizeConfig.screenWidth * 0.60,
                        ),
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.25,
                        width: SizeConfig.screenWidth,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${data.temperature.toInt()}°C',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 27,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.keyboard_arrow_down),
                                    Text(
                                      '${data.minTemperature.toInt()}°',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 5,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 2.5,
                                    ),
                                    Icon(Icons.keyboard_arrow_up),
                                    Text(
                                      '${data.maxTemperature.toInt()}°',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 5,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Feel likes ${data.feelsLikeTemperature.round().toInt()}°',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                5.5,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   width: SizeConfig.screenWidth * 0.2,
                            // ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       '${data.description}',
                            //       style: TextStyle(
                            //         fontSize:
                            //             SizeConfig.blockSizeHorizontal * 8,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Row(
                        children: [
                          Text(
                            'Detail',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: SizeConfig.screenWidth / 3.5,
                                  height: SizeConfig.screenHeight * 0.15,
                                  color: Colors.black38,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.wind,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 6,
                                      ),
                                      Text(
                                        'Wind',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                '${(data.windSpeed * 3.6).toInt()}',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    7),
                                          ),
                                          TextSpan(
                                            text: ' km/h',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: SizeConfig.screenWidth / 3.5,
                                  height: SizeConfig.screenHeight * 0.15,
                                  color: Colors.black38,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.cloud,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 6,
                                      ),
                                      Text(
                                        'Cloud',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: '${data.cloudiness}',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    7),
                                          ),
                                          TextSpan(
                                            text: ' %',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: SizeConfig.screenWidth / 3.5,
                                  height: SizeConfig.screenHeight * 0.15,
                                  color: Colors.black38,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.cloudSun,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 6,
                                      ),
                                      Text(
                                        'Sunrise',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.sunrise * 1000))}',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    7),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: SizeConfig.screenWidth / 3.5,
                                  height: SizeConfig.screenHeight * 0.15,
                                  color: Colors.black38,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.eye,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 6,
                                      ),
                                      Text(
                                        'Visibility',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: '${data.visibility / 1000}',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    7),
                                          ),
                                          TextSpan(
                                            text: ' km',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: SizeConfig.screenWidth / 3.5,
                                  height: SizeConfig.screenHeight * 0.15,
                                  color: Colors.black38,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.tint,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 6,
                                      ),
                                      Text(
                                        'Humidity',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: '${data.humidity}',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    7),
                                          ),
                                          TextSpan(
                                            text: ' %',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: SizeConfig.screenWidth / 3.5,
                                  height: SizeConfig.screenHeight * 0.15,
                                  color: Colors.black38,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.cloudMoon,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 6,
                                      ),
                                      Text(
                                        'Sunset',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.sunset * 1000))}',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    7),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Row(
                        children: [
                          Text(
                            'Hourly',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: FutureBuilder(
                            future: listFutureLocationWeather,
                            builder: (context, snapshot) {
                              print(snapshot.connectionState);
                              print(snapshot.error);
                              print(snapshot.data);
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("${snapshot.error}"),
                                );
                              } else if (snapshot.hasData) {
                                List<Weather> listData = snapshot.data;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Weather data = listData[index];
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: SizeConfig.screenWidth / 5,
                                          height:
                                              SizeConfig.screenHeight * 0.15,
                                          color: Colors.black38,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${data.temperature.toInt()}°',
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        7),
                                              ),
                                              Icon(
                                                data.getIconData(),
                                                size: SizeConfig
                                                        .blockSizeHorizontal *
                                                    7,
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                    .blockSizeVertical,
                                              ),
                                              Text(
                                                '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.time * 1000))}',
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            }),
                      ),
                      Row(
                        children: [
                          Text(
                            'Daily',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Air quality',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
