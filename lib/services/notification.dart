import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
}
