import 'package:flutter/material.dart';
import 'package:climate_app/screens/HomeScreenTEMP.dart';
import 'package:climate_app/screens/HomeScreen.dart';
import 'package:climate_app/utils/AppColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Climate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          // iconTheme: IconThemeData(color: Colors.white),
          // textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          // primaryColor: AppColor.black,
          // primarySwatch: AppColor.black,
          fontFamily: 'Roboto'),
      home: HomeScreen(),
    );
  }
}
