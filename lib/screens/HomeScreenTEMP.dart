import 'package:climate_app/api/TodayApi.dart';
import 'package:climate_app/model/WeatherModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/utils/SizeConfig.dart';
import 'package:flutter/painting.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:intl/intl.dart';

class HomeScreenTEMP extends StatefulWidget {
  @override
  _HomeScreenTEMPState createState() => _HomeScreenTEMPState();
}

class _HomeScreenTEMPState extends State<HomeScreenTEMP> {
  Future<Weather> futureLocationWeather;
  @override
  void initState() {
    super.initState();
    futureLocationWeather = TodayApi().getLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 2.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.linearToSrgbGamma(),
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSXGAk_gqaLCihXXtC4PPLBpLHnaDNXSvX_f8BMGiD5V5gmwB5Rb8eBdgvCtUVNDKJwP8&usqp=CAU"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.075,
                  child: buildFloatingSearchBar(),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.05,
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
                      labelStyle: TextStyle(
                        fontFamily: 'Glacial',
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                      ),
                      labelColor: Colors.black,
                      indicator: MaterialIndicator(
                        height: 1,
                        color: Colors.black,
                        tabPosition: TabPosition.bottom,
                        horizontalPadding: SizeConfig.blockSizeHorizontal * 2.5,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                    future: futureLocationWeather,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        Weather data = snapshot.data;
                        print(data.time);
                        print(DateFormat.yMMMd().format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                data.time * 1000)));
                        print(DateFormat.yMMMd().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                data.time * 1000)));

                        return Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 1,
                          padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 2.5),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeVertical,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(data.time * 1000))}',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    5),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical * 1,
                                      ),
                                      Text(
                                        '${data.cityName}',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    7.5),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Text(
                                        '${data.main}',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: SizeConfig.screenHeight * 0.45,
                                width: SizeConfig.screenWidth,
                                child: Icon(
                                  data.getIconData(),
                                  size: SizeConfig.screenWidth * 0.5,
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${data.temperature}°',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  27,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.keyboard_arrow_down),
                                      Text(
                                        '${data.minTemperature}°',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal *
                                            2.5,
                                      ),
                                      Icon(Icons.keyboard_arrow_up),
                                      Text(
                                        '${data.maxTemperature}°',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Feel likes ${data.feelsLikeTemperature.round().toInt()}°',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  6,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Sunrise',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        '${data.maxTemperature}°',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Sunset',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        '${data.maxTemperature}°',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Sunrise',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        '${data.maxTemperature}°',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Sunset',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        '${data.maxTemperature}°',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    }),
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
