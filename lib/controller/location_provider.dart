import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_sample/services/location_service.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  final LocationServise _locationServise = LocationServise();

  Placemark? _currentLocationName;
  Placemark? get currentLocationName => _currentLocationName;

  bool _isLoading = false;
  bool get isLoding => _isLoading;

  Future<void> determinePosition() async {
    _isLoading = true;

    bool ServiseEnabled;

    LocationPermission permission;

    ServiseEnabled = await Geolocator.isLocationServiceEnabled();

    if (!ServiseEnabled) {
      _currentPosition = null;
      notifyListeners();
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        _currentPosition = null;

        notifyListeners();

        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _currentPosition = null;
      notifyListeners();
      return;
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    print(_currentPosition);

    _currentLocationName = await _locationServise.getLocationName(
      _currentPosition,
    );
    _isLoading = false;

    print(_currentLocationName);
    notifyListeners();
  }
}
