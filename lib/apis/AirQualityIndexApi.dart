import 'package:climate_app/models/WeatherModel.dart';
import 'package:climate_app/services/Networking.dart';
import 'package:climate_app/services/Location.dart';

class AirQualityIndexApi {
  //http://api.airvisual.com/v2/nearest_city?lat=21.0278&lon=105.8342&key=79caf38e-b7cf-45f7-a6b9-6d54c06f9e69
  static final String aqiURL = 'https://api.airvisual.com/v2/nearest_city';

  static final String apiKey = '79caf38e-b7cf-45f7-a6b9-6d54c06f9e69';

  Future<Weather> getLocationAqi() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$aqiURL?lat=${location.latitude}&lon=${location.longitude}&key=$apiKey');

    var weatherData = await networkHelper.getData();
    return Weather.fromAqiJson(weatherData);
  }
}
