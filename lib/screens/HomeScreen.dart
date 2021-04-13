import 'package:climate_app/models/WeatherModel.dart';
import 'package:climate_app/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/apis/WeatherApi.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:climate_app/apis/AirQualityIndexApi.dart';

import 'TodayScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<Weather> futureLocationWeather = WeatherApi().getLocationWeather();
  // Future<List<Weather>> listHourlyFutureLocationWeather =
  //     WeatherApi().getHourlyForecast();
  // Future<List<Weather>> listDailyFutureLocationWeather =
  //     WeatherApi().getDailyForecast();
  // Future<Weather> futureAqiLocationWeather =
  //     AirQualityIndexApi().getLocationAqi();

  Future<Weather> futureLocationWeather;
  Future<List<Weather>> listHourlyFutureLocationWeather;
  Future<List<Weather>> listDailyFutureLocationWeather;
  Future<Weather> futureAqiLocationWeather;

  @override
  void initState() {
    super.initState();
    futureLocationWeather = WeatherApi().getLocationWeather();
    listHourlyFutureLocationWeather = WeatherApi().getHourlyForecast();
    listDailyFutureLocationWeather = WeatherApi().getDailyForecast();
    futureAqiLocationWeather = AirQualityIndexApi().getLocationAqi();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: buildFloatingSearchBar(),
      ),
      body: TodayScreen(
        futureLocationWeather: futureLocationWeather,
        listHourlyFutureLocationWeather: listHourlyFutureLocationWeather,
        listDailyFutureLocationWeather: listDailyFutureLocationWeather,
        aqiFutureLocationWeather: futureAqiLocationWeather,
      ),
    );
  }
}

Widget buildFloatingSearchBar() {
  return FloatingSearchBar(
    hint: 'Search city',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    openAxisAlignment: 0.0,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    leadingActions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
    ],
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );
    },
  );
}
