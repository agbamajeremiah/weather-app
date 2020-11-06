import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/ui/views/homepage.dart';
import 'package:weather_app/ui/views/welcome.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkAppOpened() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final opened = pref.getBool('appOpened');
    if (opened == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MyHomePage();
      }));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return WelcomePage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    checkAppOpened();
    return Scaffold(
      body: Container(
          color: Colors.lightBlue,
          child: Center(
            child: Text(
              'Weather app',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          )),
    );
  }
}
