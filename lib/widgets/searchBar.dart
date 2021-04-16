import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import '../provider/weatherProvider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;
  final kGoogleApiKey = "AIzaSyAhV4eqOviYbiuvrmpAvb0u1zJce1GoCng";

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          margin: EdgeInsets.symmetric(
            vertical: 25,
            horizontal: MediaQuery.of(context).size.width * .05,
          ),
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
          child: TextField(
            style: TextStyle(color: Colors.black),
            maxLines: 1,
            controller: _textController,
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
            // onTap: () async {
            //   Prediction p = await PlacesAutocomplete.show(
            //     context: context,
            //     apiKey: kGoogleApiKey,
            //     radius: 10000000,
            //     types: [],
            //     strictbounds: false,
            //     mode: Mode.overlay,
            //     language: "fr",
            //     components: [Component(Component.country, "fr")],
            //   );
            // },
            onSubmitted: (value) {
              setState(() {
                _textController.text.isEmpty
                    ? _validate = true
                    : Provider.of<WeatherProvider>(context, listen: false)
                        .searchWeatherData(location: value);
              });
            },
          ),
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
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }
}
