import 'dart:convert';
import 'package:flutter_weather/models/choice.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_weather/helper/utils.dart';
import 'package:flutter_weather/models/aqi.dart';
import 'package:flutter_weather/models/dailyWeather.dart';
import 'package:flutter_weather/models/weather.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Weather weather = Weather();
  DailyWeather currentWeather = DailyWeather();
  Aqi aqi = Aqi();
  Choice choice = Choice();

  List<Weather> listWeather = [];
  List<DailyWeather> hourlyWeather = [];
  List<DailyWeather> hourly24Weather = [];
  List<DailyWeather> sevenDayWeather = [];

  String apiKeyOpenWeatherMap = 'c129d6d70d7dd89e779d849956cde9e9';
  String apiKeyAirVisual = '79caf38e-b7cf-45f7-a6b9-6d54c06f9e69';

  Future initilize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("ic_launcher");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future<void> refreshData() async {
  //   await Location().requestService().then((value) async {
  //     print(value);
  //     if (value) {
  //       final locData = await Location().getLocation();
  //       var latitude = locData.latitude;
  //       var longitude = locData.longitude;
  //       Uri url = Uri.parse(
  //           'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKeyOpenWeatherMap');
  //       Uri dailyUrl = Uri.parse(
  //           'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKeyOpenWeatherMap');
  //       Uri aqiUrl = Uri.parse(
  //           'https://api.airvisual.com/v2/nearest_city?lat=$latitude&lon=$longitude&key=$apiKeyAirVisual');
  //       try {
  //         final response = await http.get(url);
  //         final extractedData =
  //             json.decode(response.body) as Map<String, dynamic>;
  //         weather = Weather.fromJson(extractedData);
  //       } catch (error) {
  //         notifyListeners();
  //       }
  //       try {
  //         final response = await http.get(dailyUrl);
  //         final dailyData = json.decode(response.body) as Map<String, dynamic>;
  //         currentWeather = DailyWeather.fromJson(dailyData);
  //         notifyListeners();
  //       } catch (error) {
  //         notifyListeners();
  //         throw error;
  //       }
  //       try {
  //         final response = await http.get(aqiUrl);
  //         final extractedData =
  //             json.decode(response.body) as Map<String, dynamic>;
  //         aqi = Aqi.fromJson(extractedData);
  //         notifyListeners();
  //       } catch (error) {
  //         notifyListeners();
  //       }
  //     } else {
  //       print('loi location');
  //       notifyListeners();
  //     }
  //   });
  // }

  Future instantNotification() async {
    var android = AndroidNotificationDetails('id', 'channel', 'description');

    var ios = IOSNotificationDetails();

    var platform = NotificationDetails(
      android: android,
      iOS: ios,
    );

    await _flutterLocalNotificationsPlugin.show(
        0, 'Demo instant notification', 'Tap to do something', platform,
        payload: 'Welcome to demo app');
  }

  Future stylishNotification() async {
    var android = AndroidNotificationDetails('id', 'channel', 'description',
        playSound: true,
        color: Colors.blue,
        enableLights: true,
        enableVibration: true,
        largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
        styleInformation: MediaStyleInformation(
            htmlFormatContent: true, htmlFormatTitle: true));

    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin
        .show(0, 'Climate app', 'Cloudy', platform, payload: 'Welcome');
  }

  Future dailyScheduleNotification(BuildContext context) async {
    weather = Provider.of<WeatherProvider>(context, listen: false).weather;
    print(weather.temp);
    int tempChoice =
        Provider.of<WeatherProvider>(context, listen: false).choice.tempChoice;
    int aqiIndex = Provider.of<WeatherProvider>(context, listen: false).aqi.aqi;
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        '${Temperature.getTemperatureCalUnit(weather.temp, tempChoice)} in ${weather.cityName}',
        '${toBeginningOfSentenceCase(weather.description)}. Feels like ${Temperature.getTemperature(weather.feelsLike, tempChoice)}. Air quality is $aqiIndex. ${AqiString.getAqiUserRecommend(aqiIndex)}.',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future hourlyIntervalNotification(BuildContext context) async {
    weather = Provider.of<WeatherProvider>(context, listen: false).weather;
    print(weather.temp);
    int tempChoice =
        Provider.of<WeatherProvider>(context, listen: false).choice.tempChoice;
    int aqiIndex = Provider.of<WeatherProvider>(context, listen: false).aqi.aqi;
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '${Temperature.getTemperatureCalUnit(weather.temp, tempChoice)} in ${weather.cityName}',
      '${toBeginningOfSentenceCase(weather.description)}. Feels like ${Temperature.getTemperature(weather.feelsLike, tempChoice)}. Air quality is $aqiIndex. ${AqiString.getAqiUserRecommend(aqiIndex)}.',
      RepeatInterval.hourly,
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
    );
  }

  Future dailyIntervalNotification(BuildContext context) async {
    weather = Provider.of<WeatherProvider>(context, listen: false).weather;
    print(weather.temp);
    int tempChoice =
        Provider.of<WeatherProvider>(context, listen: false).choice.tempChoice;
    int aqiIndex = Provider.of<WeatherProvider>(context, listen: false).aqi.aqi;
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '${Temperature.getTemperatureCalUnit(weather.temp, tempChoice)} in ${weather.cityName}',
      '${toBeginningOfSentenceCase(weather.description)}. Feels like ${Temperature.getTemperature(weather.feelsLike, tempChoice)}. Air quality is $aqiIndex. ${AqiString.getAqiUserRecommend(aqiIndex)}.',
      RepeatInterval.daily,
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
    );
  }

  Future deleteAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
