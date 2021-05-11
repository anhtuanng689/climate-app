import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_weather/services/internet.dart';
import 'package:app_settings/app_settings.dart';

class InternetError extends StatefulWidget {
  @override
  _InternetErrorState createState() => _InternetErrorState();
}

class _InternetErrorState extends State<InternetError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ConnectivityChangeNotifier>(builder:
          (BuildContext context,
              ConnectivityChangeNotifier connectivityChangeNotifier,
              Widget child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 100),
                child: Text(
                  connectivityChangeNotifier.pageText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (connectivityChangeNotifier.connectivity !=
                ConnectivityResult.wifi)
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    textStyle: TextStyle(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                  ),
                  child: Text('Enable Internet'),
                  onPressed: () => AppSettings.openAppSettings(),
                ),
              )
          ],
        );
      }),
    );
  }
}
