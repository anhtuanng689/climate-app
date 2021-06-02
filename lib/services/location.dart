import 'package:location/location.dart';

class LocationService {
  getLoc() async {
    Location location = Location();
    LocationData currentPosition;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentPosition = await location.getLocation();
    print("curPos: $currentPosition");
    print("dateTime: ${currentPosition.time}");

    if (currentPosition.latitude == null) {
      return null;
    } else {
      return currentPosition;
    }
  }
}
