import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_weather/widgets/internetError.dart';

class ConnectivityChangeNotifier extends ChangeNotifier {
  ConnectivityChangeNotifier() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      resultHandler(result);
    });
  }
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  String _pageText =
      'Currently connected to no network. Please connect to the internet!';

  ConnectivityResult get connectivity => _connectivityResult;
  String get pageText => _pageText;

  void resultHandler(ConnectivityResult result) {
    _connectivityResult = result;
    if (result == ConnectivityResult.none) {
      _pageText =
          'Currently connected to no network. Please connect to the internet!';
    } else {
      _pageText = 'Connected to the internet!';
    }
    notifyListeners();
  }

  void initialLoad() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    resultHandler(connectivityResult);
  }
}
