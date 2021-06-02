import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather/screens/SettingScreen.dart';
import 'package:flutter_weather/screens/addCityScreen.dart';
import 'package:flutter_weather/screens/chartScreen.dart';
import 'package:flutter_weather/screens/radarScreen.dart';
import 'package:flutter_weather/services/internet.dart';
import 'package:flutter_weather/services/notification.dart';
import 'package:flutter_weather/widgets/internetError.dart';
import 'package:provider/provider.dart';

import './Screens/hourlyWeatherScreen.dart';
import './provider/weatherProvider.dart';
import './Screens/weeklyWeatherScreen.dart';
import './Screens/homeScreen.dart';
import 'screens/aqiScreen.dart';
import 'screens/chartScreen.dart';
import 'screens/moonPhaseCalendar.dart';
import 'screens/radarScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationService(),
        ),
        ChangeNotifierProvider(
          create: (context) {
            ConnectivityChangeNotifier changeNotifier =
                ConnectivityChangeNotifier();
            //Inital load is an async function, can use FutureBuilder to show loading
            //screen while this function running. This is not covered in this tutorial
            changeNotifier.initialLoad();
            return changeNotifier;
          },
          child: InternetError(),
        ),
      ],
      child: MaterialApp(
        title: 'Climate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blue,
          accentColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          WeeklyScreen.routeName: (myCtx) => WeeklyScreen(),
          HourlyScreen.routeName: (myCtx) => HourlyScreen(),
          SettingScreen.routeName: (myCtx) => SettingScreen(),
          AddCityScreen.routeName: (myCtx) => AddCityScreen(),
          AqiScreen.routeName: (myCtx) => AqiScreen(),
          ChartScreen.routeName: (myCtx) => ChartScreen(),
          MoonPhaseCalendar.routeName: (myCtx) => MoonPhaseCalendar(),
          RadarScreen.routeName: (myCtx) => RadarScreen(),
        },
      ),
    );
  }
}
