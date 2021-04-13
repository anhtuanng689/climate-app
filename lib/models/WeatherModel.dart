import 'package:climate_app/utils/WeatherIconMapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Weather {
  double latitude;
  double longitude;

  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;

  String description;
  String iconCode;
  String main;
  String cityName;

  double windSpeed;
  int visibility;
  int cloudiness;

  double temperature;
  double maxTemperature;
  double minTemperature;
  double feelsLikeTemperature;
  double uvi;

  int aqi;

  List<Weather> forecast;

  Weather(
      {this.latitude,
      this.longitude,
      this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.description,
      this.iconCode,
      this.main,
      this.cityName,
      this.windSpeed,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.forecast,
      this.feelsLikeTemperature,
      this.visibility,
      this.cloudiness,
      this.uvi,
      this.aqi});

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      longitude: json['coord']['lon'],
      latitude: json['coord']['lat'],
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      maxTemperature: json['main']['temp_max'].toDouble(),
      minTemperature: json['main']['temp_min'].toDouble(),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      feelsLikeTemperature: json['main']['feels_like'].toDouble(),
      visibility: json['visibility'],
      cloudiness: json['clouds']['all'],
    );
  }

  static Weather fromCurrentJson(Map<String, dynamic> json) {
    final weather = json['current'];
    return Weather(
      longitude: json['lon'].toDouble(),
      latitude: json['lat'].toDouble(),
      time: weather['dt'],
      sunrise: weather['sunrise'],
      sunset: weather['sunset'],
      description: weather['weather'][0]['description'],
      iconCode: weather['weather'][0]['icon'],
      main: weather['weather'][0]['main'],
      temperature: weather['temp'].toDouble(),
      humidity: weather['humidity'],
      windSpeed: weather['wind_speed'].toDouble(),
      feelsLikeTemperature: weather['feels_like'].toDouble(),
      visibility: weather['visibility'],
      cloudiness: weather['clouds'],
      uvi: weather['uvi'].toDouble(),
    );
  }

  static Weather fromAqiJson(Map<String, dynamic> json) {
    final weather = json['data']['current']['pollution'];
    return Weather(
      aqi: weather['aqius'],
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = List<Weather>();
    for (final item in json['list']) {
      weathers.add(Weather(
          time: item['dt'],
          temperature: item['main']['temp'].toDouble(),
          iconCode: item['weather'][0]['icon']));
    }
    return weathers;
  }

  static List<Weather> fromHourlyJson(Map<String, dynamic> json) {
    final weathers = List<Weather>();
    for (final item in json['hourly']) {
      weathers.add(
        Weather(
          latitude: json['lat'].toDouble(),
          longitude: json['lon'].toDouble(),
          time: item['dt'],
          temperature: item['temp'].toDouble(),
          iconCode: item['weather'][0]['icon'],
          main: item['weather'][0]['main'],
          description: item['weather'][0]['description'],
          humidity: item['humidity'],
          windSpeed: item['wind_speed'].toDouble(),
          visibility: item['visibility'],
          uvi: item['uvi'].toDouble(),
          cloudiness: item['clouds'],
        ),
      );
    }
    return weathers;
  }

  static List<Weather> fromDailyJson(Map<String, dynamic> json) {
    final weathers = List<Weather>();
    for (final item in json['daily']) {
      weathers.add(
        Weather(
          latitude: json['lat'].toDouble(),
          longitude: json['lon'].toDouble(),
          time: item['dt'],
          sunrise: item['sunrise'],
          sunset: item['sunset'],
          maxTemperature: item['temp']['max'].toDouble(),
          minTemperature: item['temp']['min'].toDouble(),
          iconCode: item['weather'][0]['icon'],
          main: item['weather'][0]['main'],
          description: item['weather'][0]['description'],
          humidity: item['humidity'],
          windSpeed: item['wind_speed'].toDouble(),
          uvi: item['uvi'].toDouble(),
          cloudiness: item['clouds'],
        ),
      );
    }
    return weathers;
  }

  Color colorFromHexss(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  String getAqiColor(int aqi) {
    if (aqi > 300) {
      return '7d0022';
    } else if (aqi > 200) {
      return '98004b';
    } else if (aqi > 150) {
      return 'fe0000';
    } else if (aqi > 100) {
      return 'fe7c00';
    } else if (aqi > 50) {
      return 'fefe00';
    } else {
      return '00e300';
    }
  }

  String getAqiLevel(int aqi) {
    if (aqi > 300) {
      return 'Severely Polluted';
    } else if (aqi > 200) {
      return 'Heavily Polluted';
    } else if (aqi > 150) {
      return 'Moderately Polluted';
    } else if (aqi > 100) {
      return 'Lightly Polluted';
    } else if (aqi > 50) {
      return 'Good';
    } else {
      return 'Excellent';
    }
  }

  String getAqiRecommend(int aqi) {
    if (aqi > 300) {
      return 'Stay indoors and avoid physical exertion';
    } else if (aqi > 200) {
      return 'Stay indoors and avoid outdoor activities';
    } else if (aqi > 150) {
      return 'Avoid sustained and high-intensity outdoor exercises';
    } else if (aqi > 100) {
      return 'Reduce sustained and high-intensity outdoor exercises';
    } else if (aqi > 50) {
      return 'Reduce outdoor activities a bit';
    } else {
      return 'Continue outdoor activities normally';
    }
  }

  IconData getIconData() {
    switch (this.iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}
