import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/services/database.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future _getLocation() async {
    Position position;
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled == true) {
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
          .then((Position pos) {
        position = pos;
      });
    }
    return position;
  }

  Future getCityWeatherData() async {
    //get for current location
    await _getLocation().then((value) async {
      String currentURL =
          "http://api.openweathermap.org/data/2.5/weather?lat=${value.latitude.toString()}&lon=${value.longitude.toString()}&units=metric&appId=af35d0fa34ec8455681d560ef444a9bc";
      final currentResponse = await http.get(currentURL);
      String forcastURL =
          "https://api.openweathermap.org/data/2.5/onecall?lat=${value.latitude.toString()}&lon=${value.longitude.toString()}&exclude={part}&units=metric&appid=af35d0fa34ec8455681d560ef444a9bc";
      final forcastResponse = await http.get(forcastURL);
      if (currentResponse.statusCode == 200 &&
          forcastResponse.statusCode == 200) {
        var weatherData = jsonDecode(currentResponse.body);
        var forcastData = jsonDecode(forcastResponse.body);

        Map<String, dynamic> currentWeatherData = {
          "cityID": weatherData["id"],
          "cityName": weatherData["name"],
          "temp": weatherData['main']['temp'],
          "currentWeather": weatherData['weather'][0]['main'],
          "oneHourForcast": forcastData['hourly'][0]['weather'][0]['main'],
        };
        DatabaseHelper().insertweatherinfo(currentWeatherData);
      } else {
        print("error occured");
      }
    });
    //get for other cities
    String citiesURL =
        "http://api.openweathermap.org/data/2.5/group?id=2346229,2338242,2352778,2324774,2395170&appid=af35d0fa34ec8455681d560ef444a9bc";
    final forcastcitiesResponse = await http.get(citiesURL);
    if (forcastcitiesResponse.statusCode == 200) {
      var citiesweatherData = jsonDecode(forcastcitiesResponse.body);
      List cityData = citiesweatherData['list'];
      cityData.forEach((city) {
        print(city['id'] + city['name']);
      });
    } else {
      print("error occured");
    }

    // Map<String, dynamic> citiesData = {
    //   "cityID": weatherData["id"],
    //   "cityName": weatherData["name"],
    //   "temp": weatherData['main']['temp'],
    //   "currentWeather": weatherData['weather'][0]['main'],
    //   "oneHourForcast": forcastData['hourly'][0]['weather'][0]['main'],
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
    final DateTime now = DateTime.now();
    final DateFormat Formatter = DateFormat('yMMMd');
    final DateFormat timeFormat = DateFormat('jm');
    final DateTime onehour = DateTime.now().add(Duration(minutes: 60));
    final String forOneHour = timeFormat.format(onehour);
    final String formatted = Formatter.format(now);
    final String timeNow = timeFormat.format(now);
    // final String oneHourTime = onehour.format(jm);

    print(formatted);

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
            child: FutureBuilder(
              future: DatabaseHelper().getsingleweatherData(6915258),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator()));
                } else {
                  print(snapshot.data);
                  Weather data = Weather.fromMap(snapshot.data[0]);
                  return Column(
                    children: [
                      Text(
                        'Calabar, Nigeria',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(formatted,
                          style: TextStyle(
                              fontSize: 20, color: Colors.deepPurple)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20, right: 20),
                            child: Icon(
                              Icons.cloud,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "${data.temp == null ? "0" : data.temp}\u00B0c",
                                style: TextStyle(
                                    fontSize: 50, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(data.currentWeather,
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                      (data.currentWeather == 'Clouds')
                                          ? (Icons.wb_sunny)
                                          : (Icons.cloud),
                                      color: Colors.white),
                                ),
                                Text("$timeNow",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Icon(
                                      (data.oneHourForcast == 'Clouds')
                                          ? (Icons.wb_sunny)
                                          : (Icons.cloud),
                                      color: Colors.white),
                                ),
                                Text('$forOneHour',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
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
                            "$timeNow",
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
