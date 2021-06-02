import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

class UvIndex {
  static String mapUviValueToString({var uvi}) {
    String uvIndex;
    print(uvi);
    if (uvi <= 2) {
      return uvIndex = 'Low';
    } else if (uvi <= 5) {
      return uvIndex = 'Medium';
    } else if (uvi <= 7) {
      return uvIndex = 'High';
    } else if (uvi <= 10) {
      return uvIndex = 'Very High';
    } else if (uvi >= 11) {
      return uvIndex = 'Extreme';
    } else {
      uvIndex = 'Unknown';
    }
    return uvIndex;
  }
}

class Temperature {
  static String getTemperature(dynamic temp, int choice) {
    if (choice == 0) {
      return '${temp.toInt()}°';
    } else {
      return '${(temp / 5 * 9 + 32).toInt()}°';
    }
  }

  static String getTemperatureWithoutPoint(dynamic temp, int choice) {
    if (choice == 0) {
      return '${temp.toInt()}';
    } else {
      return '${(temp / 5 * 9 + 32).toInt()}';
    }
  }

  static String getTemperatureCalUnit(dynamic temp, int choice) {
    if (choice == 0) {
      return '${temp.round()}°C';
    } else {
      return '${(temp / 5 * 9 + 32).round()}°F';
    }
  }
}

class WindSpeed {
  static String getWindSpeedChoice(dynamic windSpeed, int choice) {
    if (choice == 0) {
      return '$windSpeed m/s';
    } else if (choice == 1) {
      return '${(windSpeed * 3.6).toStringAsFixed(2)} km/h';
    } else {
      return '${(windSpeed * 2.23693629).toStringAsFixed(2)} mph';
    }
  }
}

class Distance {
  static String getDistanceChoice(dynamic distance, int choice) {
    if (choice == 0) {
      return '$distance m';
    } else if (choice == 1) {
      return '${(distance / 1000).toStringAsFixed(0)} km';
    } else {
      return '${(distance * 0.000621371192).toStringAsFixed(2)} mi';
    }
  }
}

class Pressure {
  static String getPressureChoice(dynamic pressure, int choice) {
    if (choice == 0) {
      return '$pressure hPa';
    } else {
      return '${(pressure * 0.02953).toStringAsFixed(2)} inHg';
    }
  }
}

class AqiString {
  static Color colorFromHexss(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static String getAqiColor(int aqi) {
    if (aqi > 300) {
      return '7d0022';
    } else if (aqi > 200) {
      return '98004b';
    } else if (aqi > 150) {
      return 'fe0000';
    } else if (aqi > 100) {
      return 'fe7c00';
    } else if (aqi > 50) {
      return 'e5d335';
    } else {
      return '00e300';
    }
  }

  static String getAqiLevel(int aqi) {
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

  static String getAqiRecommend(int aqi) {
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

  static String getAqiUserRecommend(int aqi) {
    if (aqi > 300) {
      return 'You should stay indoors and avoid physical exertion';
    } else if (aqi > 200) {
      return 'You should stay indoors and avoid outdoor activities';
    } else if (aqi > 150) {
      return 'You should avoid sustained and high-intensity outdoor exercises';
    } else if (aqi > 100) {
      return 'You should reduce sustained and high-intensity outdoor exercises';
    } else if (aqi > 50) {
      return 'You should reduce outdoor activities a bit';
    } else {
      return 'You should continue outdoor activities normally';
    }
  }
}

class MoonString {
  static String getMoonPhase(double age) {
    String text;

    if (age < 1)
      text = "New Moon";
    else if (age < 6.38264692644)
      text = "Waxing Crescent";
    else if (age < 8.38264692644)
      text = "First Quarter";
    else if (age < 13.76529385288)
      text = "Waxing Gibbous";
    else if (age < 15.76529385288)
      text = "Full Moon";
    else if (age < 21.14794077932)
      text = "Waning Gibbous";
    else if (age < 23.14794077932)
      text = "Last Quarter";
    else if (age < 28.53058770576)
      text = "Waning Crescent";
    else
      text = "New Moon";
    return text;
  }

  static String getMoonImage(double age) {
    String text;

    if (age < 1)
      text = "new-moon";
    else if (age < 6.38264692644)
      text = "waning-crescent-left";
    else if (age < 8.38264692644)
      text = "first-quarter";
    else if (age < 13.76529385288)
      text = "waning-gibbous-left";
    else if (age < 15.76529385288)
      text = "full-moon";
    else if (age < 21.14794077932)
      text = "waxing-gibbous-right";
    else if (age < 23.14794077932)
      text = "last-quarter";
    else if (age < 28.53058770576)
      text = "waxing-crescent-right";
    else
      text = "new-moon";
    return text;
  }

  static Map<double, int> getNextMoonPhase(double age, int dateTime) {
    List<double> listStandardAge = [
      1,
      6.382646926,
      8.382646926,
      13.76529385,
      15.76529385,
      21.14794078,
      23.14794078,
      28.53058771,
      29.53058771,
    ];
    int index = 0;
    for (int i = 1; i < listStandardAge.length; i++) {
      index = i;
      if (age < listStandardAge[i]) {
        break;
      }
    }

    // print('age: $age + $index');
    // print('list index: ${listStandardAge[index]}');
    // double distance = (listStandardAge[index] - age) * 86400;
    // print('distance: $distance'); //so giay
    // double nextTime = age + distance;
    // double nextTimeAgain = nextTime +
    //     (listStandardAge[index + 1] - listStandardAge[index]) * 86400;

    double nextTime;
    double nextTimeAgain;
    double nextDay;
    double nextDayAgain;
    if (index == 8) {
      nextTime = listStandardAge[index];
      nextTimeAgain = listStandardAge[0];
      nextDay = dateTime + (nextTime - age) * 86400;
      nextDayAgain = dateTime + (nextTime - age + 0.5) * 86400;
    } else {
      nextTime = listStandardAge[index] + 0.1;
      nextTimeAgain = listStandardAge[index + 1] + 0.1;
      nextDay = dateTime + (nextTime - age) * 86400;
      nextDayAgain = dateTime + (nextTimeAgain - age) * 86400;
    }

    // print(
    //     '$age + $nextTime + $nextTimeAgain + $dateTime + $nextDay + $nextDayAgain');
    Map<double, int> result = {
      nextTime: nextDay.toInt(),
      nextTimeAgain: nextDayAgain.toInt()
    };

    return result;
  }

  static moonPhaseFormula(int year, int month, int day) {
    if (month == 1 || month == 2) {
      year -= 1;
      month += 12;
    }
    int a = (year / 100).toInt();
    // print('a: $a');
    int b = (a / 4).toInt();
    // print(b);
    double c = (2 - a + b).toDouble();
    // print(c);
    int e = (365.25 * (year + 4716)).toInt();
    // print(e);
    int f = (30.6001 * (month + 1)).toInt();
    // print(f);
    double jd = c + day + e + f - 1524.5;
    // print(jd);
    double newDay = jd - 2451549.5;
    // print(newDay);
    double newMoon = newDay / 29.53;
    // print(newMoon);
    String temp = "0.${newMoon.toString().split('.')[1].substring(0, 3)}";
    double result = double.parse(temp) * 29.53;
    return result;
  }
}

class MapString {
  static Widget mapInputToWeather(String input, BuildContext context,
      double fontSize, FontWeight fontWeight) {
    String text2;
    switch (input) {
      case 'Tornado':
        text2 = 'Tornado';
        break;
      case 'Thunderstorm':
        text2 = 'Thunderstorm';
        break;
      case 'Drizzle':
        text2 = 'Drizzly';
        break;
      case 'Rain':
        text2 = 'Raining';
        break;
      case 'Snow':
        text2 = 'Snowing';
        break;
      case 'Mist':
        text2 = 'Misty';
        break;
      case 'fog':
        text2 = 'Foggy';
        break;
      case 'Smoke':
        text2 = 'Smoky';
        break;
      case 'Squall':
        text2 = 'Squally';
        break;
      case 'Haze':
        text2 = 'Hazy';
        break;
      case 'Dust':
        text2 = 'Dusty';
        break;
      case 'Sand':
        text2 = 'Sandy';
        break;
      case 'Ash':
        text2 = 'Ashy';
        break;
      case 'Clear':
        text2 = "Sunny";
        break;
      case 'Clouds':
        text2 = "Cloudy";
        break;
      default:
        text2 = "No Info";
    }
    return Text(
      text2,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  static Icon mapStringToIcon(
      String input, BuildContext context, double iconSize) {
    IconData myIcon;
    switch (input) {
      case 'Thunderstorm':
        myIcon = WeatherIcons.wiThunderstorm;
        break;
      case 'Drizzle':
        myIcon = WeatherIcons.wiSprinkle;
        break;
      case 'Rain':
        myIcon = WeatherIcons.wiRain;
        break;
      case 'Snow':
        myIcon = WeatherIcons.wiSnow;
        break;
      case 'Clear':
        myIcon = WeatherIcons.wiDaySunny;
        break;
      case 'Clouds':
        myIcon = WeatherIcons.wiCloudy;
        break;
      case 'Mist':
        myIcon = WeatherIcons.wiFog;
        break;
      case 'fog':
        myIcon = WeatherIcons.wiFog;
        break;
      case 'Smoke':
        myIcon = WeatherIcons.wiSmoke;
        break;
      case 'Haze':
      case 'Dust':
      case 'Sand':
        myIcon = WeatherIcons.wiSandstorm;
        break;
      case 'Ash':
        myIcon = WeatherIcons.wiVolcano;
        break;
      case 'Squall':
      case 'Tornado':
        myIcon = WeatherIcons.wiHurricaneWarning;
        break;
      default:
        myIcon = WeatherIcons.wiNa;
    }
    return Icon(
      myIcon,
      size: iconSize,
      color: Theme.of(context).primaryColor,
    );
  }
}
