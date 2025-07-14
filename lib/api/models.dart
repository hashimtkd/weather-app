import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

getCurrentLocation() async {
  var position = await Geolocator.getCurrentPosition();

  getCurrentCityWeather(position);
  print('lat:${position.latitude},long:${position.longitude}');
}

getCurrentCityWeather(Position postion) async {
  var client = http.Client();
}
