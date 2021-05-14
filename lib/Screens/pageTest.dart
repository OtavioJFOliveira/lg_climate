import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'WeatherForecastPage.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


//Future<Weather> fetchWeather() async {
//  final response =
//  await http.get("http://api.openweathermap.org/data/2.5/weather?q="+City+"&appid=cb4cdffe3acbf2d5737110869c84b7c5");
//
//  if (response.statusCode == 200) {
//    return Weather.fromJson(jsonDecode(response.body));
//  } else {
//    throw Exception('Failed to load album');
//  }
//}

void decodifica(String CitySearch) async{
  var response = await http.get("http://api.openweathermap.org/data/2.5/weather?q="+CitySearch+"&appid=cb4cdffe3acbf2d5737110869c84b7c5");
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    CityName = jsonResponse['name'];
    print(CityName);
  } else {
    CityName = "Erro";
    print('Request failed with status: ${response.statusCode}.');
  }
}

class Weather {
  DataCoord coord;
  final List<WeatherList> weather;
  final String base;
  DataMain main;
  final int visibility;
  DataWind wind;
  DataClouds clouds;
  final int dt;
  DataSys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  Weather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    var listWeather = json['weather'] as List;
    List<WeatherList> weatherList = listWeather.map((i) => WeatherList.fromMap(i)).toList();
    return Weather(
      coord: DataCoord.fromJson(json["coord"]),
      weather: weatherList,
      base: json['base'],
      main: DataMain.fromMap(json["main"]),
      visibility: json['visibility'],
     // wind: DataWind.fromJson(json[" wind"]),
      clouds: DataClouds.fromJson(json["clouds"]),
      dt: json['dt'],
      sys: DataSys.fromJson(json["sys"]),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}

class WeatherList {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherList({this.id, this.main, this.description, this.icon,});

  factory WeatherList.fromMap(Map<String, dynamic> json) => WeatherList(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );
}

class DataSys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  DataSys({this.type, this.id, this.country, this.sunrise, this.sunset,});

  factory DataSys.fromJson(Map<String, dynamic>parseJson) => DataSys(
    type: parseJson["type"],
    id: parseJson["id"],
    country: parseJson["country"],
    sunrise: parseJson["sunrise"],
    sunset: parseJson["sunset"],
  );
}

class DataClouds {
  final int all;

  DataClouds({this.all,});

  factory  DataClouds.fromJson(Map<String, dynamic> parseJson) =>  DataClouds(
    all: parseJson["all"],
  );
}

class DataWind {
 /* final double speed;
  final int deg;
  final double gust;

  DataWind({this.speed, this.deg, this.gust,});

  factory DataWind.fromJson(Map<String, dynamic> parseJson) => DataWind(
    speed: parseJson["speed"].toDouble(),
    deg: parseJson["deg"],
    gust: parseJson["gust"].toDouble(),
  );*/
}

class DataCoord {
  final double lon;
  final double lat;

  DataCoord({this.lon,this.lat,});

  factory DataCoord.fromJson(Map<String, dynamic> parseJson) => DataCoord(
    lon: parseJson['lon'].toDouble(),
    lat: parseJson['lat'].toDouble(),
  );
}

class DataMain {
  var temp;
  var feelsLike;
  var tempMin;
  var tempMax;
  var pressure;
  var humidity;

  DataMain({this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure, this.humidity,});

  factory DataMain.fromMap(Map<String, dynamic> json) => DataMain(
    temp: json["temp"],
    feelsLike: json["feels_like"],
    tempMin: json["temp_min"],
    tempMax: json["temp_max"],
    pressure: json["pressure"],
    humidity: json["humidity"],
  );
}
//
//class MyApp2 extends StatefulWidget {
//  MyApp2({Key key}) : super(key: key);
//
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp2> {
//  Future<Weather> futureWeather;
//
//  @override
//  void initState() {
//    super.initState();
//    futureWeather = fetchWeather();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Fetch Data Example',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Fetch Data Example'),
//        ),
//        body: Center(
//          child: FutureBuilder<Weather>(
//            future: futureWeather,
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                //CityName = snapshot.data.name;
//                return Text(snapshot.data.name);
//              } else if (snapshot.hasError) {
//                return Text("${snapshot.error}");
//              }
//
//              // By default, show a loading spinner.
//              return CircularProgressIndicator();
//            },
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//





















