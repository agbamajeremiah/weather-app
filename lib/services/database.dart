import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _db;
  Future<Database> get database async {
    if (_db != null) {
      return _db;
    } else {
      _db = await createDatabase();
      return _db;
    }
  }

  Future<Database> createDatabase() async {
    final path = await getDatabasesPath();
    String actualDbpath = join(path, "weather_app.db");
    return await openDatabase(
      actualDbpath,
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute("CREATE TABLE WeatherData("
            "cityID INTEGER UNIQUE PRIMARY KEY,"
            "cityName TEXT,"
            "temp REAL,"
            "currentWeather TEXT,"
            "oneHourForcast TEXT"
            ")");
      },
    );
  }

  Future<void> insertweatherinfo(Map weatherData) async {
    print("inserting data");
    final db = await database;
    await db.insert('weatherData', weatherData,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("data inserted");
  }

  Future getsingleweatherData(int cityID) async {
    //  to get the results
    final db = await database;
    final weatherData =
        await db.query("weatherData", where: "cityID = ?", whereArgs: [cityID]);
    return weatherData;
  }

  Future getallweatherData() async {
    //  to get the results
    final db = await database;
    final weatherData = await db.query("weatherData");
    return weatherData;
  }

  Future<void> updateweatherData(Map weatherData) async {
    //  to get the results
    final db = await database;
    await db.update("weatherData", weatherData);
  }
}
