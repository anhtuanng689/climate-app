import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_weather/database/DatabaseProvider.dart';
import 'package:flutter_weather/helper/utils.dart';
import 'package:flutter_weather/models/weather.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/screens/SettingScreen.dart';
import 'package:flutter_weather/screens/addCityScreen.dart';
import 'package:provider/provider.dart';

import 'fadeIn.dart';

class EndDrawer extends StatefulWidget {
  final wData;
  final List<Weather> lWeather;
  final List<String> cityList;
  EndDrawer({Key key, this.cityList, this.lWeather, this.wData})
      : super(key: key);

  @override
  _EndDrawerState createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  final List<String> listDrop = ['Remove'];

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  deleteCity(dynamic val) {
    setState(() => this.widget.cityList.removeWhere((data) => data == val));
  }

  deleteDBCity(selectedValue) async {
    await DatabaseProvider.deleteCity(selectedValue);
  }

  Widget _weatherLocationBuilder(
      dynamic weather, dynamic wData, BuildContext context) {
    return FadeIn(
      delay: 0.01,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Provider.of<WeatherProvider>(context, listen: false)
              .searchWeatherData(location: weather.cityName);
        },
        child: Container(
          key: UniqueKey(),
          height: MediaQuery.of(context).size.height * 0.15,
          margin: EdgeInsets.symmetric(vertical: 15),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 15,
                offset: Offset(6, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    weather.cityName,
                    style: _style1.copyWith(fontSize: 22),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 10),
                    child: MapString.mapStringToIcon(
                        weather.currently, context, 30),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    Temperature.getTemperatureCalUnit(
                        weather.temp, wData.tempChoice),
                    style: _style1.copyWith(fontSize: 38),
                  ),
                  Spacer(),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.grey.shade100,
                    ),
                    child: PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.blue,
                      ),
                      onSelected: (selectedValue) {
                        setState(() {
                          print('selectedValue: $selectedValue');
                          deleteCity(selectedValue);
                          deleteDBCity(selectedValue);
                          print(this.widget.cityList);
                          Provider.of<WeatherProvider>(context, listen: false)
                              .getWeatherLocationEndDrawer();
                        });
                      },
                      itemBuilder: (BuildContext ctx) => [
                        PopupMenuItem(
                          key: UniqueKey(),
                          child: Text('Remove'),
                          value: weather.cityName,
                          textStyle: _style2,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              // color: Colors.lightGreen,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('add city clicked');
                      Navigator.of(context).pushNamed(AddCityScreen.routeName);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add city',
                          style: _style1,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      print('setting clicked');
                      Navigator.of(context).pushNamed(SettingScreen.routeName);
                    },
                    child: Icon(
                      Icons.settings,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: widget.lWeather
                        .map((item) => _weatherLocationBuilder(
                            item, widget.wData, context))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
