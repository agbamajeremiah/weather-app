import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String temp;
  String pressure;
  String humidity;

  Future getCityWeatherData() async {
    final response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=calabar&units=metric&appId=af35d0fa34ec8455681d560ef444a9bc');
    print(response);
    if (response.statusCode == 200) {
      var weatherData = jsonDecode(response.body);
      print(weatherData['main']);
      setState(() {
        temp = weatherData['main']['temp'].toString();
        pressure = weatherData['main']['pressure'].toString();
        humidity = weatherData['main']['humidity'].toString();
      });
    } else {
      print("error occured");
    }
  }

  @override
  void initState() {
    getCityWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    double _height = mediaQuery.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.lightBlue,
            height: _height * 0.3,
            child: Column(
              children: [
                Text(
                  'Calabar, Nigeria',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text('date',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 20),
                      child: Icon(
                        Icons.cloud,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "${temp == null ? "0" : temp}\u00B0c",
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('mostly raining',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            color: Colors.white,
                          ),
                          Text('time',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            color: Colors.white,
                          ),
                          Text('time',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: _height * 0.05,
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '7:00 am',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Lagos',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '27C',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Icon(
                            Icons.cloud,
                            color: Colors.orange,
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '7:00 am',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Lagos',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '27C',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Icon(
                            Icons.cloud,
                            color: Colors.orange,
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '7:00 am',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Lagos',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '27C',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Icon(
                            Icons.cloud,
                            color: Colors.orange,
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '7:00 am',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Lagos',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '27C',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Icon(
                            Icons.cloud,
                            color: Colors.orange,
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
