import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_weather/database/DatabaseProvider.dart';
import 'package:flutter_weather/helper/utils.dart';
import 'package:flutter_weather/models/choice.dart';
import 'package:flutter_weather/screens/HomeScreen.dart';
import 'package:flutter_weather/services/notification.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../provider/weatherProvider.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/settingScreen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  updateChoice(Choice choice) async {
    await DatabaseProvider.updateChoice(choice);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NotificationService>(context, listen: false).initilize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              updateChoice(
                  Provider.of<WeatherProvider>(context, listen: false).choice);
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'Setting',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: Column(
            children: [
              Divider(color: Colors.black),
              Container(
                height: mediaQuery.height * 0.085,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Temperature',
                      style: _style1,
                    ),
                    Spacer(),
                    ToggleSwitch(
                      minWidth: mediaQuery.width * 0.45 / 2,
                      minHeight: mediaQuery.height * 0.15 / 3,
                      fontSize: 15,
                      initialLabelIndex: weatherData.tempChoice,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      labels: ['°C', '°F'],
                      activeBgColors: [Colors.blue, Colors.pink],
                      onToggle: (index) {
                        print('switched to: $index');
                        print('temp choice from: ${weatherData.tempChoice}');
                        weatherData.getTemperatureChoice(index);
                        // updateChoice(weatherData.choice);
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                height: mediaQuery.height * 0.085,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Wind speed',
                      style: _style1,
                    ),
                    Spacer(),
                    ToggleSwitch(
                      minWidth: mediaQuery.width * 0.45 / 3,
                      minHeight: mediaQuery.height * 0.15 / 3,
                      fontSize: 15,
                      initialLabelIndex: weatherData.windSpeedChoice,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      labels: ['m/s', 'km/h', 'mph'],
                      activeBgColors: [Colors.blue, Colors.pink, Colors.purple],
                      onToggle: (index) {
                        print('switched to: $index');
                        print(
                            'temp choice from: ${weatherData.windSpeedChoice}');
                        weatherData.getWindSpeedChoice(index);
                        // updateChoice(weatherData.choice);
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                height: mediaQuery.height * 0.085,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Distance',
                      style: _style1,
                    ),
                    Spacer(),
                    ToggleSwitch(
                      minWidth: mediaQuery.width * 0.45 / 3,
                      minHeight: mediaQuery.height * 0.15 / 3,
                      fontSize: 15,
                      initialLabelIndex: weatherData.distanceChoice,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      labels: ['m', 'km', 'mi'],
                      activeBgColors: [Colors.blue, Colors.pink, Colors.purple],
                      onToggle: (index) {
                        print('switched to: $index');
                        print(
                            'distance choice from: ${weatherData.distanceChoice}');
                        weatherData.getDistanceChoice(index);
                        // updateChoice(weatherData.choice);
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                height: mediaQuery.height * 0.085,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pressure',
                      style: _style1,
                    ),
                    Spacer(),
                    ToggleSwitch(
                      minWidth: mediaQuery.width * 0.45 / 2,
                      minHeight: mediaQuery.height * 0.15 / 3,
                      fontSize: 15,
                      initialLabelIndex: weatherData.pressureChoice,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      labels: ['hPa', 'inHg'],
                      activeBgColors: [Colors.blue, Colors.pink],
                      onToggle: (index) {
                        print('switched to: $index');
                        print(
                            'pressure choice from: ${weatherData.pressureChoice}');
                        weatherData.getPressureChoice(index);
                        // updateChoice(weatherData.choice);
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                height: mediaQuery.height * 0.085,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Notification',
                      style: _style1,
                    ),
                    Spacer(),
                    ToggleSwitch(
                      minWidth: mediaQuery.width * 0.45 / 3,
                      minHeight: mediaQuery.height * 0.15 / 3,
                      fontSize: 15,
                      initialLabelIndex: weatherData.notificationChoice,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      labels: ['hourly', 'daily', 'off'],
                      activeBgColors: [Colors.blue, Colors.pink, Colors.purple],
                      onToggle: (index) {
                        print('switched to: $index');
                        print(
                            'notification choice from: ${weatherData.notificationChoice}');
                        weatherData.getNotificationChoice(index);
                        // updateChoice(weatherData.choice);
                        if (index == 0) {
                          Provider.of<NotificationService>(context,
                                  listen: false)
                              .hourlyIntervalNotification(context);
                        } else if (index == 1) {
                          Provider.of<NotificationService>(context,
                                  listen: false)
                              .dailyIntervalNotification(context);
                        } else {
                          Provider.of<NotificationService>(context,
                                  listen: false)
                              .deleteAllNotification();
                        }
                      },
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: mediaQuery.size.height * 0.085,
              //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Row(children: [
              //         Text(
              //           'Notification',
              //           style: _style1,
              //         ),
              //         Spacer(),
              //         ElevatedButton(
              //             onPressed: () async {
              //               setState(() {
              //                 Provider.of<NotificationService>(context,
              //                         listen: false)
              //                     .hourlyIntervalNotification(context);
              //               });
              //             },
              //             child: Text('Press')),
              //       ]),
              //     ],
              //   ),
              // ),
              Divider(color: Colors.black),
              Container(
                height: mediaQuery.height * 0.085,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      Text(
                        'Weather data',
                        style: _style1,
                      ),
                      Spacer(),
                      Text(
                        'Open Weather Map',
                        style: _style2.copyWith(color: Colors.grey),
                      ),
                    ]),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                height: mediaQuery.height * 0.085,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      Text(
                        'Air quality data',
                        style: _style1,
                      ),
                      Spacer(),
                      Text(
                        'Air Visual',
                        style: _style2.copyWith(color: Colors.grey),
                      ),
                    ]),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                height: mediaQuery.height * 0.085,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      Text(
                        'About us',
                        style: _style1,
                      ),
                    ]),
                  ],
                ),
              ),
              Divider(color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
