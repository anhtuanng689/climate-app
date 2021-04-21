import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/database/DatabaseProvider.dart';
import 'package:flutter_weather/models/city.dart';
import 'package:flutter_weather/screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../provider/weatherProvider.dart';

class AddCityScreen extends StatefulWidget {
  static const routeName = '/addCityScreen';

  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  final _textController = TextEditingController();
  bool _validate = false;
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
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Add city',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Row(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 15,
                  offset: Offset(8, 6),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: loadingCities
                ? CircularProgressIndicator()
                : AutoCompleteTextField<City>(
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
                            .cityList
                            .add(item.city);
                        Provider.of<WeatherProvider>(context, listen: false)
                            .getWeatherLocationEndDrawer();
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.SCALE,
                          body: Text(
                            'Added ${item.city}',
                            style: _style1,
                          ),
                          btnOk: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        )..show();
                      });
                    },
                    itemBuilder: (context, item) {
                      return autoCompleteCityColumn(item);
                    },
                    key: key,
                  ),
          ),
        ]),
      ),
    );
  }
}
