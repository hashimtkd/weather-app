import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServise {
  Future<Placemark?> getLocationName(Position? position) async {
    if (position != null) {
      try {
        final placeMark = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placeMark.isNotEmpty) {
          print(placeMark);

          return placeMark[3];
        }
      } catch (e) {
        print('$e');
      }
    }

    return null;
  }
}
