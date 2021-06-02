import 'package:flutter/material.dart';
import 'package:flutter_weather/database/DatabaseProvider.dart';
import 'package:flutter_weather/models/AqiDetail.dart';
import 'package:flutter_weather/models/choice.dart';
import 'package:flutter_weather/models/city.dart';
import 'package:flutter_weather/models/moon.dart';
import 'package:flutter_weather/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_weather/models/chart.dart';
import '../models/weather.dart';
import '../models/dailyWeather.dart';
import '../models/aqi.dart';

class WeatherProvider with ChangeNotifier {
  String apiKeyOpenWeatherMap = 'c129d6d70d7dd89e779d849956cde9e9';
  String apiKeyAirVisual = '79caf38e-b7cf-45f7-a6b9-6d54c06f9e69';

  Weather weather = Weather();
  DailyWeather currentWeather = DailyWeather();
  Aqi aqi = Aqi();
  AqiDetail aqiDetail = AqiDetail();
  Choice choice = Choice();
  Chart chart = Chart();
  Moon moon = Moon();

  LocationService locationService = LocationService();

  List<String> cityList = [];

  List<Weather> listWeather = [];
  List<DailyWeather> hourlyWeather = [];
  List<DailyWeather> hourly24Weather = [];
  List<DailyWeather> sevenDayWeather = [];
  List<City> listCity = [];
  List<Chart> listChart = [];

  bool loading;
  bool isRequestError = false;
  bool isLocationError = false;
  bool loadingDrawer = false;
  bool pressedDrawer = false;

  int tempChoice;
  int windSpeedChoice;
  int distanceChoice;
  int pressureChoice;
  int notificationChoice;

  int dateTime;

  loadCalUnit() async {
    choice = await DatabaseProvider.fetchChoice();
    print(
        'i${choice.id} t${choice.tempChoice} w${choice.windSpeedChoice} d${choice.distanceChoice} p${choice.pressureChoice} n${choice.notificationChoice}');
    tempChoice = choice.tempChoice;
    windSpeedChoice = choice.windSpeedChoice;
    distanceChoice = choice.distanceChoice;
    pressureChoice = choice.pressureChoice;
    notificationChoice = choice.notificationChoice;
    notifyListeners();
  }

  loadCity() async {
    print('loading city');
    listCity.clear();
    listCity = await DatabaseProvider.fetchCity();
    print(listCity.length);
    print(listCity.isNotEmpty);
    print(listCity);
    cityList.clear();
    for (var city in listCity) {
      cityList.add(city.cityName);
      print(city.cityName);
    }
    notifyListeners();
  }

  getWeatherData() async {
    loading = true;
    // isRequestError = false;
    // isLocationError = false;

    // bool checkPermission = await Location().requestService();
    // print(checkPermission);

    final locData = await locationService.getLoc();

    print("locData: $locData");

    if (locData == null) {
      loading = false;
      isLocationError = true;
      notifyListeners();
    } else {
      var latitude = locData.latitude;
      var longitude = locData.longitude;
      dateTime = (locData.time / 1000).toInt();
      Uri url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKeyOpenWeatherMap');
      Uri dailyUrl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKeyOpenWeatherMap');

      Uri aqiDetailUrl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKeyOpenWeatherMap&units=metric');

      Uri aqiUrl = Uri.parse(
          'https://api.airvisual.com/v2/nearest_city?lat=$latitude&lon=$longitude&key=$apiKeyAirVisual');

      Uri moonUrl = Uri.parse(
          'https://api.farmsense.net/v1/moonphases/?d=${dateTime.toInt()}');

      try {
        final response = await http.get(url);
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        weather = Weather.fromJson(extractedData);
      } catch (error) {
        loading = false;
        this.isRequestError = true;
        notifyListeners();
      }
      try {
        final response = await http.get(dailyUrl);
        final dailyData = json.decode(response.body) as Map<String, dynamic>;
        currentWeather = DailyWeather.fromJson(dailyData);
        var tempHourly = [];
        var temp24Hour = [];
        var tempSevenDay = [];
        var tempPrepChart = [];
        List items = dailyData['daily'];
        List itemsHourly = dailyData['hourly'];
        tempHourly = itemsHourly
            .map((item) => DailyWeather.fromHourlyJson(item))
            .toList()
            .skip(1)
            .take(3)
            .toList();
        temp24Hour = itemsHourly
            .map((item) => DailyWeather.fromHourlyJson(item))
            .toList()
            .skip(1)
            .take(24)
            .toList();
        tempSevenDay = items
            .map((item) => DailyWeather.fromDailyJson(item))
            .toList()
            .skip(1)
            .take(7)
            .toList();
        tempPrepChart = itemsHourly
            .map((item) => Chart.fromMap(item))
            .toList()
            .skip(1)
            .take(5)
            .toList();
        hourlyWeather = tempHourly;
        hourly24Weather = temp24Hour;
        sevenDayWeather = tempSevenDay;
        listChart = tempPrepChart;
      } catch (error) {
        loading = false;
        this.isRequestError = true;
        notifyListeners();
        throw error;
      }

      try {
        final response = await http.get(aqiUrl);
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        aqi = Aqi.fromJson(extractedData);
        loading = false;
      } catch (error) {
        loading = false;
        this.isRequestError = true;
        notifyListeners();
      }

      try {
        final response = await http.get(aqiDetailUrl);
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        aqiDetail = AqiDetail.fromJson(extractedData);
        loading = false;
      } catch (error) {
        loading = false;
        this.isRequestError = true;
        notifyListeners();
      }

      try {
        final response = await http.get(moonUrl);
        final extractedData = json.decode(response.body);
        moon = Moon.fromJson(extractedData[0]);
      } catch (error) {
        loading = false;
        this.isRequestError = true;
        notifyListeners();
      }

      loadCalUnit();
      notifyListeners();
    }
  }

  searchWeatherData({String location}) async {
    loading = true;
    isRequestError = false;
    isLocationError = false;

    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKeyOpenWeatherMap');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }
    var latitude = weather.lat;
    var longitude = weather.long;
    dateTime = weather.time;
    print(latitude);
    print(longitude);
    print(dateTime);
    Uri dailyUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKeyOpenWeatherMap');
    try {
      final response = await http.get(dailyUrl);
      final dailyData = json.decode(response.body) as Map<String, dynamic>;
      currentWeather = DailyWeather.fromJson(dailyData);
      var tempHourly = [];
      var temp24Hour = [];
      var tempSevenDay = [];
      var tempPrepChart = [];
      List items = dailyData['daily'];
      List itemsHourly = dailyData['hourly'];
      tempHourly = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(3)
          .toList();
      temp24Hour = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(24)
          .toList();
      tempSevenDay = items
          .map((item) => DailyWeather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(7)
          .toList();
      tempPrepChart = itemsHourly
          .map((item) => Chart.fromMap(item))
          .toList()
          .skip(0)
          .take(5)
          .toList();
      hourlyWeather = tempHourly;
      hourly24Weather = temp24Hour;
      sevenDayWeather = tempSevenDay;
      listChart = tempPrepChart;
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }

    Uri aqiUrl = Uri.parse(
        'https://api.airvisual.com/v2/nearest_city?lat=$latitude&lon=$longitude&key=$apiKeyAirVisual');

    Uri aqiDetailUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKeyOpenWeatherMap&units=metric');
    try {
      final response = await http.get(aqiUrl);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      aqi = Aqi.fromJson(extractedData);
      loading = false;
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }

    try {
      final response = await http.get(aqiDetailUrl);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      aqiDetail = AqiDetail.fromJson(extractedData);
      loading = false;
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
    }

    Uri moonUrl = Uri.parse(
        'https://api.farmsense.net/v1/moonphases/?d=${dateTime.toInt()}');
    try {
      final response = await http.get(moonUrl);
      final extractedData = json.decode(response.body);
      moon = Moon.fromJson(extractedData[0]);
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
    }

    notifyListeners();
  }

  getWeatherLocationEndDrawer() async {
    loadingDrawer = true;
    print('cityList1: $cityList');
    print('listWeather1: $listWeather');
    cityList.clear();
    listWeather.clear();
    listCity.clear();

    listCity = await DatabaseProvider.fetchCity();

    print('listCity after fetch: $listCity');

    for (var city in listCity) {
      cityList.add(city.cityName);
    }

    print('cityList: $cityList');
    print('listWeather: $listWeather');

    for (var index in cityList) {
      Uri url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$index&units=metric&appid=$apiKeyOpenWeatherMap');
      try {
        final response = await http.get(url);
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        listWeather.add(Weather.fromJson(extractedData));
      } catch (error) {
        loadingDrawer = false;
        notifyListeners();
        throw error;
      }
    }
    loadingDrawer = false;
    notifyListeners();
  }

  getTemperatureChoice(int index) {
    tempChoice = index;
    choice.tempChoice = index;
    notifyListeners();
  }

  getWindSpeedChoice(int index) {
    windSpeedChoice = index;
    choice.windSpeedChoice = index;
    notifyListeners();
  }

  getDistanceChoice(int index) {
    distanceChoice = index;
    choice.distanceChoice = index;
    notifyListeners();
  }

  getPressureChoice(int index) {
    pressureChoice = index;
    choice.pressureChoice = index;
    notifyListeners();
  }

  getNotificationChoice(int index) {
    notificationChoice = index;
    print(notificationChoice);
    choice.notificationChoice = index;
    notifyListeners();
  }
}
