// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_sample/controller/location_provider.dart';
import 'package:weather_sample/controller/searchBox_provider.dart';
import 'package:weather_sample/controller/wetherService_provider.dart';
import 'package:weather_sample/greeting%20Data/greeting_data.dart';
import 'package:weather_sample/lotties/lotteis_path.dart';
import 'package:weather_sample/view/splaash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final locationProvider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );

    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;

        if (city != null) {
          Provider.of<WeatherserviceProvider>(
            // ignore: use_build_context_synchronously
            context,
            listen: false,
          ).fetchWeatherDataByCity(city);
        }
      }
    });

    super.initState();
  }

  final _citySearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueGrey),
        body: Provider.of<LocationProvider>(context).isLoding == true
            ? SplashScreen()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.blueGrey,
                child:
                    Provider.of<WeatherserviceProvider>(context).isLoding ==
                        true
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Lottie.asset(
                          "assets/lotties/satellite antenna.json",
                        ),
                      )
                    : Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 10,

                            child: SizedBox(
                              height: 80,
                              width: 170,

                              child: Consumer<LocationProvider>(
                                builder:
                                    (
                                      context,
                                      LocationProvider location,
                                      child,
                                    ) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/icons/location.png",
                                            height: 20,
                                            width: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                location
                                                    .currentLocationName!
                                                    .subLocality!,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                location
                                                    .currentLocationName!
                                                    .locality!,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                getGreeting(),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: SizedBox(
                              height: 50,
                              width: 40,

                              child: IconButton(
                                onPressed: () {
                                  Provider.of<SearchboxProvider>(
                                    context,
                                    listen: false,
                                  ).toggleSearchBoxVisiblity();
                                },

                                icon: Icon(Icons.search, size: 40),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            right: 20,

                            child: Consumer<SearchboxProvider>(
                              builder:
                                  (context, SearchboxProvider provider, child) {
                                    return Visibility(
                                      visible: provider.searchBoxOpacity,
                                      child: SizedBox(
                                        height: 40,
                                        width: 280,

                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _citySearchController,
                                                decoration: InputDecoration(
                                                  hint: Text(
                                                    'Type name of place here...',
                                                  ),
                                                ),
                                                onTap: () {
                                                  Provider.of<
                                                        SearchboxProvider
                                                      >(context, listen: false)
                                                      .toggleUivisibility();
                                                },
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                final city =
                                                    _citySearchController.text
                                                        .trim();

                                                Provider.of<
                                                      WeatherserviceProvider
                                                    >(context, listen: false)
                                                    .fetchWeatherDataByCity(
                                                      city,
                                                    );

                                                Provider.of<SearchboxProvider>(
                                                  context,
                                                  listen: false,
                                                ).weatherFetched();
                                              },
                                              icon: Icon(Icons.search),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.2),

                            child: Consumer<SearchboxProvider>(
                              builder: (context, SearchboxProvider provider, child) {
                                return Visibility(
                                  visible: provider.uiVisibility,
                                  child: SizedBox(
                                    height: 325,
                                    width: 290,

                                    child: Consumer<WeatherserviceProvider>(
                                      builder:
                                          (
                                            context,
                                            WeatherserviceProvider weather,
                                            child,
                                          ) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Lottie.asset(
                                                  lottiesPath[weather
                                                          .weatherModel!
                                                          .weather![0]
                                                          .main!] ??
                                                      '',
                                                  height: 150,
                                                  width: 150,
                                                ),
                                                Text(
                                                  ' ${weather.weatherModel!.main!.temp!.toStringAsFixed(0)}°C',
                                                  style: TextStyle(
                                                    fontSize: 50,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  ' ${weather.weatherModel!.name}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  weather
                                                      .weatherModel!
                                                      .weather![0]
                                                      .main!,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  time(
                                                    Provider.of<
                                                          WeatherserviceProvider
                                                        >(context)
                                                        .weatherModel!
                                                        .dt,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, 0.89),
                            child: Consumer<SearchboxProvider>(
                              builder: (context, SearchboxProvider provider, child) {
                                return Visibility(
                                  visible: provider.uiVisibility,
                                  child: Container(
                                    padding: EdgeInsets.all(15),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    height: 150,
                                    width: 250,

                                    child: Consumer<WeatherserviceProvider>(
                                      builder:
                                          (
                                            context,
                                            WeatherserviceProvider weather,
                                            child,
                                          ) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/temperature humidity  high.png",
                                                      height: 40,
                                                      width: 30,
                                                    ),

                                                    Column(
                                                      children: [
                                                        Text('Temp Max'),
                                                        Text(
                                                          '${weather.weatherModel!.main!.tempMax!.toStringAsFixed(0)}°C',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 20),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/icons/temperature humidity low.png",
                                                          height: 40,
                                                          width: 30,
                                                        ),

                                                        Column(
                                                          children: [
                                                            Text('Temp Min'),
                                                            Text(
                                                              '${weather.weatherModel!.main!.tempMin!.toStringAsFixed(0)}°C',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,

                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/sun.png",
                                                      height: 40,
                                                      width: 30,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text('Sunrise'),
                                                        Text(
                                                          time(
                                                            weather
                                                                .weatherModel!
                                                                .sys!
                                                                .sunrise,
                                                          ).toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 10),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/icons/moon.png",
                                                          height: 40,
                                                          width: 30,
                                                        ),

                                                        Column(
                                                          children: [
                                                            Text('Sunset'),
                                                            Text(
                                                              time(
                                                                weather
                                                                    .weatherModel!
                                                                    .sys!
                                                                    .sunset,
                                                              ),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
      ),
    );
  }

  String time(int? time) {
    // Convert Unix timestamp to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time! * 1000);

    // Format the DateTime into a readable time
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return formattedTime;
  }

  getGreeting() {
    final time = DateTime.now().hour;

    if (time >= 5 && time < 12) {
      return greetingData[0];
    }
    if (time >= 12 && time < 16) {
      return greetingData[1];
    }
    if (time >= 16 && time < 22) {
      return greetingData[2];
    }
    if (time >= 22 && time < 5) {
      return greetingData[3];
    }
  }
}
