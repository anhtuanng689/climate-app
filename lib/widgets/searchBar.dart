import 'package:flutter/material.dart';
import 'package:flutter_weather/database/DatabaseProvider.dart';
import 'package:flutter_weather/models/city.dart';
import 'package:provider/provider.dart';
import '../provider/weatherProvider.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'fadeIn.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;
  bool _pressedDrawer = false;
  final kGoogleApiKey = "AIzaSyAhV4eqOviYbiuvrmpAvb0u1zJce1GoCng";
  GlobalKey<AutoCompleteTextFieldState<City>> key = new GlobalKey();
  bool loadingCities = true;

  List<City> _citiesList = [];

  void loadCities() async {
    _citiesList = await DatabaseProvider.loadCities();
    setState(() {
      loadingCities = false;
    });
  }

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 16,
  );

  Widget autoCompleteCityColumn(City city) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue.shade400,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                city.city,
                style: _style1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadCities();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('city loading: $loadingCities');
    // print('city list: $_citiesList');
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          margin: EdgeInsets.symmetric(
            vertical: 25,
            horizontal: MediaQuery.of(context).size.width * .05,
          ),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.3),
          //       spreadRadius: 1,
          //       blurRadius: 15,
          //       offset: Offset(8, 6),
          //     ),
          //   ],
          //   borderRadius: BorderRadius.circular(15),
          // ),
          child: loadingCities
              ? CircularProgressIndicator()
              : FadeIn(
                  delay: 0.01,
                  child: AutoCompleteTextField<City>(
                    suggestions: _citiesList,
                    clearOnSubmit: true,
                    style: _style1,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      errorText: _validate ? null : null,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 0,
                        bottom: 11,
                        top: 11,
                        right: 15,
                      ),
                      hintText: "Search city",
                    ),
                    itemFilter: (item, query) {
                      return item.city
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.city.compareTo(b.city);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        print(item.city);
                        Provider.of<WeatherProvider>(context, listen: false)
                            .searchWeatherData(location: item.city);
                      });
                    },
                    itemBuilder: (context, item) {
                      return autoCompleteCityColumn(item);
                    },
                    key: key,
                  ),
                ),
          // TextField(
          //   style: TextStyle(color: Colors.black),
          //   maxLines: 1,
          //   controller: _textController,
          //   decoration: InputDecoration(
          //     hintStyle: TextStyle(color: Colors.grey),
          //     errorText: _validate ? null : null,
          //     border: InputBorder.none,
          //     focusedBorder: InputBorder.none,
          //     enabledBorder: InputBorder.none,
          //     icon: Padding(
          //       padding: const EdgeInsets.only(left: 10),
          //       child: Icon(
          //         Icons.search,
          //         color: Colors.black,
          //       ),
          //     ),
          //     contentPadding: EdgeInsets.only(
          //       left: 0,
          //       bottom: 11,
          //       top: 11,
          //       right: 15,
          //     ),
          //     hintText: "Search city",
          //   ),
          //   onSubmitted: (value) {
          //     setState(() {
          //       _textController.text.isEmpty
          //           ? _validate = true
          //           : Provider.of<WeatherProvider>(context, listen: false)
          //               .searchWeatherData(location: value);
          //     });
          //   },
          // ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.11,
          margin: EdgeInsets.symmetric(
            vertical: 25,
            // horizontal: MediaQuery.of(context).size.width * .05,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 15,
                offset: Offset(8, 6),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () async {
              Scaffold.of(context).openEndDrawer();
              if (!_pressedDrawer) {
                await Provider.of<WeatherProvider>(context, listen: false)
                    .getWeatherLocationEndDrawer();
                _pressedDrawer = !_pressedDrawer;
              }
            },
          ),
        ),
      ],
    );
  }
}
