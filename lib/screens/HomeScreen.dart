import 'package:climate_app/model/WeatherModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/utils/SizeConfig.dart';
import 'package:flutter/painting.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:climate_app/services/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weatherModel = WeatherModel();

  bool loading;
  var data;

  int temp;
  @override
  void initState() {
    loading = true;
    super.initState();
    fetchData().then((value) {
      setState(() {
        data = value;
        print(data);
        print(data['main']['temp']);
        // weatherModel = data;
        // print(weatherModel.cnt);
      });

      print('1$loading');
      print('2$loading');
      updateUI();
    });
  }

  void updateUI() {
    setState(() {
      if (data == null) {
        return;
      }

      weatherModel = weatherModelFromJson(data);

      temp = weatherModel.main.temp;
      // var condition = weatherData['weather'][0]['id'];
      // weatherIcon = weather.getWeatherIcon(condition);
      // weatherMessage = weather.getMessage(temperature);
      // cityName = weatherData['name'];
    });
  }

  Future<dynamic> fetchData() async {
    return await Services().getLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    print('3$loading');
    // WeatherModel _weatherModel = loading ? null : data;
    // print('5${_weatherModel.weather[0].description}');
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEAE4CA),
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: buildFloatingSearchBar(),
                ),
                Flexible(
                  flex: 1,
                  child: DefaultTabController(
                    length: 3,
                    child: TabBar(
                        indicatorColor: Colors.green,
                        tabs: [
                          Tab(
                            text: "Today",
                          ),
                          Tab(
                            text: "Tomorrow",
                          ),
                          Tab(
                            text: "6 Days",
                          ),
                        ],
                        labelStyle: TextStyle(fontSize: 20),
                        labelColor: Colors.black,
                        indicator: MaterialIndicator(
                          height: 1,
                          color: Colors.black,
                          tabPosition: TabPosition.bottom,
                          horizontalPadding: 10,
                        )
                        // DotIndicator(
                        //   color: Colors.black,
                        //   distanceFromCenter: 16,
                        //   radius: 3,
                        //   paintingStyle: PaintingStyle.fill,
                        // ),
                        ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'wednesday, 18 nov',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Tokyo',
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(
                                  'Japan',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Container(
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  'Sunny',
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: SizeConfig.screenHeight * 0.45,
                          width: SizeConfig.screenWidth,
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/f/f1/Ski_trail_rating_symbol_red_circle.png',
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                loading
                                    ? CircularProgressIndicator()
                                    : Text(
                                        temp.toString() ?? 'lag',
                                        // data['current']['temp'].toString(),
                                        // '19°',
                                        style: TextStyle(
                                          fontSize: 80,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Min: 17°',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Max: 25°',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
          icon: Icon(Icons.place),
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
