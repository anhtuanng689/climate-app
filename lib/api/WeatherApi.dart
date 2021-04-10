import 'package:climate_app/model/WeatherModel.dart';
import 'package:climate_app/services/Networking.dart';
import 'package:climate_app/services/Location.dart';

class WeatherApi {
  //https://api.openweathermap.org/data/2.5/weather?lat=21.0278&lon=105.8342&appid=c129d6d70d7dd89e779d849956cde9e9&units=metric&lang=vi
  static final String weatherURL =
      'https://api.openweathermap.org/data/2.5/weather';

  static final String forecastHourlyURL =
      'https://api.openweathermap.org/data/2.5/forecast';

  static final String forecastDailyURL =
      'https://api.openweathermap.org/data/2.5/onecall';

  static final String apiKey = 'c129d6d70d7dd89e779d849956cde9e9';

  Future<Weather> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$weatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return Weather.fromJson(weatherData);
  }

  Future<List<Weather>> getHourlyForecast() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$forecastHourlyURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    List<Weather> weathers = Weather.fromForecastJson(weatherData);
    return weathers;
  }

  Future<List<Weather>> getDailyForecast() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$forecastDailyURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    List<Weather> weathers = Weather.fromOneCallJson(weatherData);
    return weathers;
  }
}
