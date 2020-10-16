import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/ui/views/homepage.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Icon(
            Icons.list,
            color: Colors.blue,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Weather App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Image.asset('assets/rain.jpeg'),
          Text(
            'Calabar, Nig',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.setBool('appOpened', true).whenComplete(() =>
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MyHomePage();
                  })));
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child:
                    Text('Get Started', style: TextStyle(color: Colors.white)),
              ),
              decoration: BoxDecoration(
                color: Colors.yellow.shade600,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 90,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
