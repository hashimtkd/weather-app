import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_sample/controller/searchBox_provider.dart';
import 'package:weather_sample/controller/wetherService_provider.dart';
import 'package:weather_sample/view/home_page.dart';
import 'package:weather_sample/controller/location_provider.dart';
import 'package:weather_sample/view/splaash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return LocationProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return WeatherserviceProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SearchboxProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}
