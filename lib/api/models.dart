import 'package:geolocator/geolocator.dart';

getCurrentLocation() async {
  var position = await Geolocator.getCurrentPosition();
  if (position != null) {
    print('lat:${position.latitude},long:${position.longitude}');
  } else {
    print('data unavilabe');
  }
}
