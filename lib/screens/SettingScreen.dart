import 'package:flutter/material.dart';
import 'package:flutter_weather/helper/utils.dart';
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

  @override
  void initState() {
    super.initState();
    Provider.of<NotificationService>(context, listen: false).initilize();
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
            'Setting',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: Column(
            children: [
              Divider(color: Colors.black),
              Container(
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
                      minWidth: 90.0,
                      minHeight: 35.0,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      labels: ['°C', '°F'],
                      activeBgColors: [Colors.blue, Colors.pink],
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
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
                      minWidth: 60,
                      minHeight: 35.0,
                      initialLabelIndex: 1,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      labels: ['m/s', 'km/h', 'mph'],
                      activeBgColors: [Colors.blue, Colors.pink, Colors.purple],
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(children: [
                      Text(
                        'Get widgets in homescreen',
                        style: _style1,
                      ),
                    ]),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(children: [
                      Text(
                        'Weather data',
                        style: _style1,
                      ),
                      Spacer(),
                      Text(
                        'One Call API',
                        style: _style2.copyWith(color: Colors.grey),
                      ),
                    ]),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(children: [
                      Text(
                        'Notification',
                        style: _style1,
                      ),
                      Spacer(),
                      ElevatedButton(
                          onPressed: () async {
                            await Provider.of<NotificationService>(context,
                                    listen: false)
                                .stylishNotification();
                          },
                          child: Text('Press')),
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
