// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_sample/api/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueGrey),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blueGrey,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,

                child: SizedBox(
                  height: 58,
                  width: 170,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/location.png",
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dubai',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Good morning',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                    onPressed: () {},
                    icon: Icon(Icons.search, size: 40),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                right: 20,

                child: SizedBox(
                  height: 40,
                  width: 280,

                  child: TextFormField(
                    decoration: InputDecoration(
                      hint: Text('Type name of place here...'),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.2),

                child: SizedBox(
                  height: 325,
                  width: 290,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/lotties/sunny cloud.json',
                        height: 200,
                        width: 200,
                      ),
                      Text(
                        '27°C',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cloudy',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '7:00pm',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.89),
                child: Container(
                  padding: EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2),
                    ],
                  ),
                  height: 150,
                  width: 250,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
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
                                '27°C',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/icons/temperature humidity low.png",
                                height: 40,
                                width: 30,
                              ),

                              Column(
                                children: [
                                  Text('Temp Max'),
                                  Text(
                                    '27°C',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset(
                            "assets/icons/sun.png",
                            height: 40,
                            width: 30,
                          ),
                          Column(
                            children: [
                              Text('Temp Max'),
                              Text(
                                '27°C',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/icons/moon.png",
                                height: 40,
                                width: 30,
                              ),

                              Column(
                                children: [
                                  Text('Temp Max'),
                                  Text(
                                    '27°C',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
