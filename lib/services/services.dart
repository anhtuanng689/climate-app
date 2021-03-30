import 'package:climate_app/services/networking.dart';
import 'package:climate_app/model/Location.dart';

class Services {
  //https://api.openweathermap.org/data/2.5/onecall?lat=20&lon=25&appid=c129d6d70d7dd89e779d849956cde9e9&units=metric&lang=vi
  static final String openWeatherMapURL =
      'https://api.openweathermap.org/data/2.5/weather';
  static final String apiKey = 'c129d6d70d7dd89e779d849956cde9e9';

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric&lang=vi');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
