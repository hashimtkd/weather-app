import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:weather_sample/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherserviceProvider extends ChangeNotifier {
  WeatherModel? _weatherModel;
  WeatherModel? get weatherModel => _weatherModel;

  bool isLoding = false;

  String error = '';

  Future<void> fetchWeatherDataByCity(String city) async {
    try {
      isLoding = true;

      final apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=1f6885b3c45e43e1ad60951cb6ea85e7&units=metric';

      print(apiUrl);
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print(data);

        if (data != null) {
          _weatherModel = WeatherModel.fromJson(data);
          await Future.delayed(Duration(seconds: 2), () {
            isLoding = false;
            notifyListeners();
          });

          notifyListeners();
        }
      } else {
        error = 'failed to load data';
        notifyListeners();
      }
    } catch (e) {
      error = 'failed to load $e';
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }
}
