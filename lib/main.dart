import 'package:flutter/material.dart';
import 'package:climate_app/screens/HomeScreen.dart';
import 'package:climate_app/utils/AppColor.dart';
import 'package:flutter/services.dart';
import 'screens/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          // Loading is done, return the app:
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
      },
    );
  }
}
