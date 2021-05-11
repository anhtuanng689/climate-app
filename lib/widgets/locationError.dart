import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather/screens/HomeScreen.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../provider/weatherProvider.dart';

class LocationError extends StatefulWidget {
  @override
  _LocationErrorState createState() => _LocationErrorState();
}

class _LocationErrorState extends State<LocationError> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context).getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context, listen: true);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            color: Colors.black,
            size: 75,
          ),
          SizedBox(height: 10),
          Text(
            'Your Location is Disabled',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Text(
              "Please open app setting and turn on location permission",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                textStyle: TextStyle(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 50),
              ),
              child: Text('Enable Location'),
              onPressed: () async {
                weatherData.loading = true;
                weatherData.isRequestError = false;
                weatherData.isLocationError = false;
                // Navigator.pushNamed(context, HomeScreen.routeName);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
                // Navigator.popAndPushNamed(context, HomeScreen.routeName)
                //     .then(onGoBack(context));
                // Navigator.pushReplacementNamed(context, HomeScreen.routeName)
                //     .then(onGoBack(context));
              }
              // weatherData.loading = true;
              // weatherData.isRequestError = false;
              // weatherData.isLocationError = false;
              //
              // await Location().requestService().then((value) async {
              //   if (value) {
              //     weather = await weatherData.getWeatherData();
              //   } else {
              //     weather = null;
              //   }
              // });
              //
              // if (weather == null)
              //   showDialog(
              //     context: context,
              //     barrierDismissible: false,
              //     builder: (context) {
              //       return AlertDialog(
              //         title: Text('Cannot Get Your Location'),
              //         content: SingleChildScrollView(
              //           child: ListBody(
              //             children: <Widget>[
              //               Text(
              //                   'This app uses your phone location to get your location accurate weather data. Please turn on location and check location permission'),
              //             ],
              //           ),
              //         ),
              //         actions: <Widget>[
              //           TextButton(
              //             child: Text('OK'),
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //           ),
              //         ],
              //       );
              //     },
              //   );

              // await location.requestService().then((value) async {
              //   if (value) {
              //     await Provider.of<WeatherProvider>(context, listen: false)
              //         .getWeatherData();
              //   } else
              //     showDialog(
              //       context: context,
              //       barrierDismissible: false,
              //       builder: (context) {
              //         return AlertDialog(
              //           title: Text('Cannot Get Your Location'),
              //           content: SingleChildScrollView(
              //             child: ListBody(
              //               children: <Widget>[
              //                 Text(
              //                     'This app uses your phone location to get your location accurate weather data'),
              //               ],
              //             ),
              //           ),
              //           actions: <Widget>[
              //             TextButton(
              //               child: Text('OK'),
              //               onPressed: () {
              //                 Navigator.of(context).pop();
              //               },
              //             ),
              //           ],
              //         );
              //       },
              //     );
              // });
              ),
        ],
      ),
    );
  }
}
