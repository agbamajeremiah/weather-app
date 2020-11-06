class Weather {
  int cityID;
  String city;
  double temp;
  String currentWeather;
  String oneHourForcast;

  Weather(this.city, this.temp, this.currentWeather, this.oneHourForcast);
  Weather.fromMap(Map<String, dynamic> map) {
    cityID = map['cityId'];
    city = map['city'];
    temp = map['temp'];
    currentWeather = map['currentWeather'];
    oneHourForcast = map['oneHourForcast'];
  }
}
