import 'dart:convert';
import 'package:climate_app/model/WeatherModel.dart';
import 'package:climate_app/services/networking.dart';
import 'package:climate_app/services/Location.dart';

class TodayApi {
  //https://api.openweathermap.org/data/2.5/weather?lat=21.0278&lon=105.8342&appid=c129d6d70d7dd89e779d849956cde9e9&units=metric&lang=vi
  static final String weatherURL =
      'https://api.openweathermap.org/data/2.5/weather';

  static final String forecastHourlyURL =
      'https://api.openweathermap.org/data/2.5/forecast';

  static final String apiKey = 'c129d6d70d7dd89e779d849956cde9e9';

  Future<Weather> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$weatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric&lang=vi');

    var weatherData = await networkHelper.getData();
    return Weather.fromJson(weatherData);
  }

  Future<List<Weather>> getForecast() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$forecastHourlyURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric&lang=vi');

    var weatherData = await networkHelper.getData();
    List<Weather> weathers = Weather.fromForecastJson(weatherData);
    return weathers;
  }
}
