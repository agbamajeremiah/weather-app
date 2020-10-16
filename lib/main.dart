import 'package:flutter/material.dart';
import 'package:weather_app/ui/views/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SharedPreferences perf = await SharedPreferences.getInstance();
    // perf.getBool('appOpened');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen());
  }
}
