import 'package:climate_app/model/WeatherModel.dart';
import 'package:climate_app/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:climate_app/api/TodayApi.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'TodayScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Weather> futureLocationWeather;
  Future<List<Weather>> listFutureLocationWeather;

  @override
  void initState() {
    super.initState();
    futureLocationWeather = TodayApi().getLocationWeather();
    listFutureLocationWeather = TodayApi().getForecast();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: buildFloatingSearchBar(),
      ),
      body: TodayScreen(
        futureLocationWeather: futureLocationWeather,
        listFutureLocationWeather: listFutureLocationWeather,
      ),
    );
    // return DefaultTabController(
    //   length: 3,
    //   child: Scaffold(
    //       body: NestedScrollView(
    //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //       return <Widget>[
    //         SliverAppBar(
    //           elevation: 0,
    //           centerTitle: true,
    //           floating: true,
    //           pinned: true,
    //           leading: IconButton(
    //             onPressed: () {},
    //             icon: Icon(Icons.menu),
    //           ),
    //           title: TabBar(
    //             isScrollable: true,
    //             tabs: [
    //               Tab(child: Text('Today')),
    //               Tab(child: Text('Tomorrow')),
    //               Tab(child: Text('5 days')),
    //             ],
    //           ),
    //           actions: [
    //             IconButton(
    //               onPressed: () {},
    //               icon: Icon(Icons.search),
    //             ),
    //           ],
    //         ),
    //       ];
    //     },
    //     body: TabBarView(
    //       children: <Widget>[
    //         TodayScreen(
    //           futureLocationWeather: futureLocationWeather,
    //           listFutureLocationWeather: listFutureLocationWeather,
    //         ),
    //         SingleChildScrollView(
    //           child: Container(
    //             height: SizeConfig.screenHeight * 1.5,
    //             width: SizeConfig.screenWidth,
    //             child: FutureBuilder(
    //                 future: futureLocationWeather,
    //                 builder: (context, snapshot) {
    //                   if (snapshot.hasError) {
    //                     return Center(
    //                       child: Text("${snapshot.error}"),
    //                     );
    //                   } else if (snapshot.hasData) {
    //                     Weather data = snapshot.data;
    //                     print(DateFormat.yMMMd().format(
    //                         DateTime.fromMillisecondsSinceEpoch(
    //                             data.time * 1000)));
    //
    //                     return Container(
    //                       padding: EdgeInsets.all(
    //                           SizeConfig.blockSizeHorizontal * 2.5),
    //                       child: Column(
    //                         children: [
    //                           Container(
    //                             width: SizeConfig.screenWidth,
    //                             height: SizeConfig.screenHeight * 0.15,
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text(
    //                                       '${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(data.time * 1000))}',
    //                                       style: TextStyle(
    //                                           fontSize: SizeConfig
    //                                                   .blockSizeHorizontal *
    //                                               5),
    //                                     ),
    //                                     SizedBox(
    //                                       height:
    //                                           SizeConfig.blockSizeVertical * 1,
    //                                     ),
    //                                     Text(
    //                                       '${data.cityName}',
    //                                       style: TextStyle(
    //                                           fontSize: SizeConfig
    //                                                   .blockSizeHorizontal *
    //                                               7.5),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Container(
    //                                   child: RotatedBox(
    //                                     quarterTurns: 1,
    //                                     child: Text(
    //                                       '${data.main}',
    //                                       style: TextStyle(
    //                                           fontSize: SizeConfig
    //                                                   .blockSizeHorizontal *
    //                                               10),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           Container(
    //                             height: SizeConfig.screenHeight * 0.45,
    //                             width: SizeConfig.screenWidth,
    //                             child: Icon(
    //                               data.getIconData(),
    //                               size: SizeConfig.screenWidth * 0.60,
    //                             ),
    //                           ),
    //                           Container(
    //                             height: SizeConfig.screenHeight * 0.25,
    //                             width: SizeConfig.screenWidth,
    //                             child: Column(
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       '${data.temperature}°',
    //                                       style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeHorizontal *
    //                                                 27,
    //                                       ),
    //                                       textAlign: TextAlign.start,
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   children: [
    //                                     Icon(Icons.keyboard_arrow_down),
    //                                     Text(
    //                                       '${data.minTemperature}°',
    //                                       style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeHorizontal *
    //                                                 5,
    //                                       ),
    //                                       textAlign: TextAlign.start,
    //                                     ),
    //                                     SizedBox(
    //                                       width:
    //                                           SizeConfig.blockSizeHorizontal *
    //                                               2.5,
    //                                     ),
    //                                     Icon(Icons.keyboard_arrow_up),
    //                                     Text(
    //                                       '${data.maxTemperature}°',
    //                                       style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeHorizontal *
    //                                                 5,
    //                                       ),
    //                                       textAlign: TextAlign.start,
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 SizedBox(
    //                                   height: SizeConfig.blockSizeVertical,
    //                                 ),
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       'Feel likes ${data.feelsLikeTemperature.round().toInt()}°',
    //                                       style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeHorizontal *
    //                                                 6,
    //                                       ),
    //                                       textAlign: TextAlign.start,
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: SizeConfig.blockSizeVertical * 3,
    //                           ),
    //                           Row(
    //                             children: [
    //                               Text('Detail'),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: SizeConfig.blockSizeVertical * 3,
    //                           ),
    //                           Column(
    //                             children: [
    //                               Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   ClipRRect(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     child: Container(
    //                                       width: SizeConfig.screenWidth / 3.5,
    //                                       height:
    //                                           SizeConfig.screenHeight * 0.12,
    //                                       color: Colors.black38,
    //                                       child: Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceEvenly,
    //                                         children: [
    //                                           Icon(Icons.visibility),
    //                                           Text('Feels likes'),
    //                                           Text('23'),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   ClipRRect(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     child: Container(
    //                                       width: SizeConfig.screenWidth / 3.5,
    //                                       height:
    //                                           SizeConfig.screenHeight * 0.12,
    //                                       color: Colors.black38,
    //                                       child: Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceEvenly,
    //                                         children: [
    //                                           Icon(Icons.visibility),
    //                                           Text('Feels likes'),
    //                                           Text('23'),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   ClipRRect(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     child: Container(
    //                                       width: SizeConfig.screenWidth / 3.5,
    //                                       height:
    //                                           SizeConfig.screenHeight * 0.12,
    //                                       color: Colors.black38,
    //                                       child: Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceEvenly,
    //                                         children: [
    //                                           Icon(Icons.visibility),
    //                                           Text('Feels likes'),
    //                                           Text('23'),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                               SizedBox(
    //                                 height: SizeConfig.blockSizeVertical * 3,
    //                               ),
    //                               Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: SizeConfig.screenWidth / 3.5,
    //                                     height: SizeConfig.screenHeight * 0.12,
    //                                     color: Colors.black38,
    //                                     child: Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                       children: [
    //                                         Icon(Icons.visibility),
    //                                         Text('Feels likes'),
    //                                         Text('23'),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth / 3.5,
    //                                     height: SizeConfig.screenHeight * 0.12,
    //                                     color: Colors.black38,
    //                                     child: Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                       children: [
    //                                         Icon(Icons.visibility),
    //                                         Text('Feels likes'),
    //                                         Text('23'),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth / 3.5,
    //                                     height: SizeConfig.screenHeight * 0.12,
    //                                     color: Colors.black38,
    //                                     child: Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                       children: [
    //                                         Icon(Icons.visibility),
    //                                         Text('Feels likes'),
    //                                         Text('23'),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: SizeConfig.blockSizeVertical * 3,
    //                           ),
    //                           Row(
    //                             children: [
    //                               Text('Air quality'),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     );
    //                   }
    //                   return Container(
    //                       child: Center(
    //                     child: CircularProgressIndicator(),
    //                   ));
    //                 }),
    //           ),
    //         ),
    //         SingleChildScrollView(
    //           child: Container(
    //             height: SizeConfig.screenHeight * 1.5,
    //             width: SizeConfig.screenWidth,
    //             child: FutureBuilder(
    //                 future: futureLocationWeather,
    //                 builder: (context, snapshot) {
    //                   if (snapshot.hasError) {
    //                     return Center(
    //                       child: Text("${snapshot.error}"),
    //                     );
    //                   } else if (snapshot.hasData) {
    //                     Weather data = snapshot.data;
    //                     print(DateFormat.yMMMd().format(
    //                         DateTime.fromMillisecondsSinceEpoch(
    //                             data.time * 1000)));
    //
    //                     return Container(
    //                       padding: EdgeInsets.all(
    //                           SizeConfig.blockSizeHorizontal * 2.5),
    //                       child: Column(
    //                         children: [
    //                           Container(
    //                             width: SizeConfig.screenWidth,
    //                             height: SizeConfig.screenHeight * 0.15,
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text(
    //                                       '${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(data.time * 1000))}',
    //                                       style: TextStyle(
    //                                           fontSize: SizeConfig
    //                                                   .blockSizeHorizontal *
    //                                               5),
    //                                     ),
    //                                     SizedBox(
    //                                       height:
    //                                           SizeConfig.blockSizeVertical * 1,
    //                                     ),
    //                                     Text(
    //                                       '${data.cityName}',
    //                                       style: TextStyle(
    //                                           fontSize: SizeConfig
    //                                                   .blockSizeHorizontal *
    //                                               7.5),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Container(
    //                                   child: RotatedBox(
    //                                     quarterTurns: 1,
    //                                     child: Text(
    //                                       '${data.main}',
    //                                       style: TextStyle(
    //                                           fontSize: SizeConfig
    //                                                   .blockSizeHorizontal *
    //                                               10),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           Container(
    //                             height: SizeConfig.screenHeight * 0.45,
    //                             width: SizeConfig.screenWidth,
    //                             child: Icon(
    //                               data.getIconData(),
    //                               size: SizeConfig.screenWidth * 0.60,
    //                             ),
    //                           ),
    //                           Container(
    //                             height: SizeConfig.screenHeight * 0.25,
    //                             width: SizeConfig.screenWidth,
    //                             child: Column(
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       '${data.temperature}°',
    //                                       style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeHorizontal *
    //                                                 27,
    //                                       ),
    //                                       textAlign: TextAlign.start,
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   children: [
    //                                     Icon(Icons.keyboard_arrow_down),
    //                                     Text(
    //                                       '${data.minTemperature}°',
    //                                       style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeHorizontal *
    //                                                 5,
    //                                       ),
    //                                       textAlign: TextAlign.start,
    //                                     ),
    //                                     SizedBox(
    //                                       width:
    //                                           SizeConfig.blockSizeHorizontal *
    //                                               2.5,
    //                                     ),
    //                                     Icon(Icons.keyboard_arrow_up),
    //                                     Text(
    //                                       '${data.maxTemperature}°',
    //                                       style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeHorizontal *
    //                                                 5,
    //                                       ),
    //                                       textAlign: TextAlign.start,
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 SizedBox(
    //                                   height: SizeConfig.blockSizeVertical,
    //                                 ),
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       'Feel likes ${data.feelsLikeTemperature.round().toInt()}°',
    //                                       style: TextStyle(
    //                                         fontSize:
    //                                             SizeConfig.blockSizeHorizontal *
    //                                                 6,
    //                                       ),
    //                                       textAlign: TextAlign.start,
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: SizeConfig.blockSizeVertical * 3,
    //                           ),
    //                           Row(
    //                             children: [
    //                               Text('Detail'),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: SizeConfig.blockSizeVertical * 3,
    //                           ),
    //                           Column(
    //                             children: [
    //                               Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   ClipRRect(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     child: Container(
    //                                       width: SizeConfig.screenWidth / 3.5,
    //                                       height:
    //                                           SizeConfig.screenHeight * 0.12,
    //                                       color: Colors.black38,
    //                                       child: Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceEvenly,
    //                                         children: [
    //                                           Icon(Icons.visibility),
    //                                           Text('Feels likes'),
    //                                           Text('23'),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   ClipRRect(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     child: Container(
    //                                       width: SizeConfig.screenWidth / 3.5,
    //                                       height:
    //                                           SizeConfig.screenHeight * 0.12,
    //                                       color: Colors.black38,
    //                                       child: Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceEvenly,
    //                                         children: [
    //                                           Icon(Icons.visibility),
    //                                           Text('Feels likes'),
    //                                           Text('23'),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   ClipRRect(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     child: Container(
    //                                       width: SizeConfig.screenWidth / 3.5,
    //                                       height:
    //                                           SizeConfig.screenHeight * 0.12,
    //                                       color: Colors.black38,
    //                                       child: Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceEvenly,
    //                                         children: [
    //                                           Icon(Icons.visibility),
    //                                           Text('Feels likes'),
    //                                           Text('23'),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                               SizedBox(
    //                                 height: SizeConfig.blockSizeVertical * 3,
    //                               ),
    //                               Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: SizeConfig.screenWidth / 3.5,
    //                                     height: SizeConfig.screenHeight * 0.12,
    //                                     color: Colors.black38,
    //                                     child: Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                       children: [
    //                                         Icon(Icons.visibility),
    //                                         Text('Feels likes'),
    //                                         Text('23'),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth / 3.5,
    //                                     height: SizeConfig.screenHeight * 0.12,
    //                                     color: Colors.black38,
    //                                     child: Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                       children: [
    //                                         Icon(Icons.visibility),
    //                                         Text('Feels likes'),
    //                                         Text('23'),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: SizeConfig.screenWidth / 3.5,
    //                                     height: SizeConfig.screenHeight * 0.12,
    //                                     color: Colors.black38,
    //                                     child: Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceEvenly,
    //                                       children: [
    //                                         Icon(Icons.visibility),
    //                                         Text('Feels likes'),
    //                                         Text('23'),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: SizeConfig.blockSizeVertical * 3,
    //                           ),
    //                           Row(
    //                             children: [
    //                               Text('Air quality'),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     );
    //                   }
    //                   return Container(
    //                       child: Center(
    //                     child: CircularProgressIndicator(),
    //                   ));
    //                 }),
    //           ),
    //         ),
    //       ],
    //     ),
    //   )),
    // );
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
