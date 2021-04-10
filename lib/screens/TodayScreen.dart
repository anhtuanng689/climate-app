import 'package:climate_app/model/WeatherModel.dart';
import 'package:climate_app/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:climate_app/widgets/ProgressBar.dart';
import 'package:climate_app/widgets/DetailProgressBar.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({
    Key key,
    @required this.futureLocationWeather,
    this.listHourlyFutureLocationWeather,
    this.listDailyFutureLocationWeather,
    this.aqiFutureLocationWeather,
  }) : super(key: key);

  final Future<Weather> futureLocationWeather;
  final Future<List<Weather>> listHourlyFutureLocationWeather;
  final Future<List<Weather>> listDailyFutureLocationWeather;
  final Future<Weather> aqiFutureLocationWeather;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: SizeConfig.screenHeight * 3.5,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 2),
        child: Column(
          children: [
            FutureBuilder(
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
                                      '${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(data.time * 1000))}',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical * 1,
                                    ),
                                    Text(
                                      '${data.cityName}',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  7.5),
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
                                              SizeConfig.blockSizeHorizontal *
                                                  8),
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
                                                SizeConfig.blockSizeHorizontal *
                                                    27,
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
                                                SizeConfig.blockSizeHorizontal *
                                                    5,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  2.5,
                                        ),
                                        Icon(Icons.keyboard_arrow_up),
                                        Text(
                                          '${data.maxTemperature.toInt()}°',
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    5,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                          ),
                                          Text(
                                            'Wind',
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
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
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                          ),
                                          Text(
                                            'Cloud',
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
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
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                          ),
                                          Text(
                                            'Sunrise',
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                          ),
                                          Text(
                                            'Visibility',
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text:
                                                    '${data.visibility / 1000}',
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
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                          ),
                                          Text(
                                            'Humidity',
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
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
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                          ),
                                          Text(
                                            'Sunset',
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
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
                        ],
                      ),
                    );
                  }
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                }),
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
            Container(
              height: SizeConfig.screenHeight * 0.23,
              child: FutureBuilder(
                  future: listHourlyFutureLocationWeather,
                  builder: (context, snapshot) {
                    // print(snapshot.connectionState);
                    // print(snapshot.error);
                    // print(snapshot.data);
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
                                height: SizeConfig.screenHeight * 0.15,
                                color: Colors.black38,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${data.temperature.toInt()}°',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  7),
                                    ),
                                    Icon(
                                      data.getIconData(),
                                      size: SizeConfig.blockSizeHorizontal * 7,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    Text(
                                      '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(data.time * 1000))}',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 5,
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
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              height: SizeConfig.screenHeight * 0.675,
              child: FutureBuilder(
                  future: listDailyFutureLocationWeather,
                  builder: (context, snapshot) {
                    // print(snapshot.connectionState);
                    // print(snapshot.error);
                    // print(snapshot.data);
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      List<Weather> listData = snapshot.data;
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length - 1,
                        itemBuilder: (context, index) {
                          Weather data = listData[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical,
                                horizontal: SizeConfig.blockSizeHorizontal),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: SizeConfig.screenHeight * 0.075,
                                color: Colors.black38,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth * 0.3,
                                            child: Text(
                                              index == 0
                                                  ? 'Today'
                                                  : '${DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch(data.time * 1000))}',
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            data.getIconData(),
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${data.maxTemperature.round().toInt()}°',
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      6,
                                                ),
                                              ),
                                              Text(
                                                ' ',
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4,
                                                ),
                                              ),
                                              Text(
                                                '${data.minTemperature.toInt()}',
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                  'Air quality',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical,
            ),
            FutureBuilder(
                future: aqiFutureLocationWeather,
                builder: (context, snapshot) {
                  print(snapshot.connectionState);
                  print(snapshot.error);
                  print(snapshot.data);
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    Weather data = snapshot.data;
                    return Container(
                      height: SizeConfig.screenHeight * 0.095,
                      width: SizeConfig.screenWidth,
                      child: Row(
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.225,
                            child: Center(
                              child: Text(
                                '${data.aqi}',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 6,
                                  color: data.colorFromHexss(
                                      data.getAqiColor(data.aqi)),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.getAqiLevel(data.aqi),
                                  style: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical * 3,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 0.5,
                                ),
                                Text(
                                  data.getAqiRecommend(data.aqi),
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2,
                                      color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            SizedBox(
              height: SizeConfig.blockSizeVertical,
            ),
            DetailProgressBar(
              width: SizeConfig.screenWidth * 0.95,
              height: SizeConfig.safeBlockVertical * 2,
              radius: 0,
              assetsLimit: 500,
              assets: [
                MyAssets(size: 50, num: 0),
                MyAssets(size: 50, num: 50),
                MyAssets(size: 50, num: 100),
                MyAssets(size: 50, num: 150),
                MyAssets(size: 100, num: 200),
                MyAssets(size: 100, num: 300),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical,
            ),
            MyAssetsBar(
              width: SizeConfig.screenWidth * 0.95,
              height: SizeConfig.safeBlockVertical,
              background: colorFromHex("CFD8DC"),
              radius: 0,
              assetsLimit: 500,
              assets: [
                MyAsset(size: 50, color: colorFromHex("00e300")),
                MyAsset(size: 50, color: colorFromHex("fefe00")),
                MyAsset(size: 50, color: colorFromHex("fe7c00")),
                MyAsset(size: 50, color: colorFromHex("fe0000")),
                MyAsset(size: 100, color: colorFromHex("98004b")),
                MyAsset(size: 200, color: colorFromHex("7d0022")),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Excellent',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      color: Colors.grey.shade400),
                ),
                Text(
                  'Severe',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      color: Colors.grey.shade400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
