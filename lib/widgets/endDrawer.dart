import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/helper/utils.dart';
import 'package:flutter_weather/models/weather.dart';

class EndDrawer extends StatelessWidget {
  final List<Weather> lWeather;
  final List<String> cityList;
  EndDrawer({this.cityList, this.lWeather});

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  // Widget _weatherLocationBuilder(
  //     {String cityName,
  //     bool current,
  //     String condition,
  //     int temp,
  //     BuildContext context}) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.15,
  //     margin: EdgeInsets.symmetric(vertical: 15),
  //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(15),
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.4),
  //           blurRadius: 15,
  //           offset: Offset(6, 8),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               cityName,
  //               style: _style1.copyWith(fontSize: 22),
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             current
  //                 ? Icon(
  //                     Icons.location_on_outlined,
  //                     color: Colors.blue,
  //                   )
  //                 : SizedBox(
  //                     width: 5,
  //                   ),
  //             Spacer(),
  //             Padding(
  //               padding: EdgeInsets.fromLTRB(0, 0, 5, 10),
  //               child: MapString.mapStringToIcon(condition, context, 30),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               '$temp°C',
  //               style: _style1.copyWith(fontSize: 45),
  //             ),
  //             Spacer(),
  //             Container(
  //               width: 40,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(45),
  //                 color: Colors.grey.shade100,
  //               ),
  //               child: IconButton(
  //                 onPressed: () {},
  //                 icon: Icon(
  //                   Icons.more_vert,
  //                   color: Colors.blue,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _weatherLocationBuilder(dynamic weather, BuildContext context) {
    return Container(
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
              weather.currently
                  ? Icon(
                      Icons.location_on_outlined,
                      color: Colors.blue,
                    )
                  : SizedBox(
                      width: 5,
                    ),
              Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 10),
                child:
                    MapString.mapStringToIcon(weather.condition, context, 30),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${weather.temp}°C',
                style: _style1.copyWith(fontSize: 45),
              ),
              Spacer(),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.grey.shade100,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
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
                  Spacer(),
                  Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: lWeather
                        .map((item) => _weatherLocationBuilder(item, context))
                        .toList(),
                  ),
                  // for (var item in this.cityList)
                  //   _weatherLocationBuilder(
                  //       cityName: item,
                  //       current:
                  //           this.cityList.indexOf(item) == 0 ? true : false,
                  //       condition: wData.weather.currently,
                  //       temp: wData.weather.temp,
                  //       context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
