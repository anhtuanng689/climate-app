import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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

  Future dailyNotification() async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Climate app',
        'Cloudy',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future dailyNotification1() async {
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Climate app',
      'Cloudy',
      RepeatInterval.everyMinute,
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
    );
  }
}
