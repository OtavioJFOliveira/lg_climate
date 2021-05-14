import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lg_climate/Screens/WeatherForecastPage.dart';

Future<WeatherCoord> fetchWeatherCoord() async {
  await Geolocator.getCurrentPosition().then((value) => {
   lat = value.latitude.toString(),
    lon = value.longitude.toString(),
  });
  final response =
  await http.get("http://api.openweathermap.org/data/2.5/find?lat="+lat+"&lon="+lon+"&cnt=10&units=metric&appid=cb4cdffe3acbf2d5737110869c84b7c5");

  if (response.statusCode == 200) {
    return WeatherCoord.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to search for city');
  }
}

class WeatherCoord {
  final String message;
  final int count;
  final List<CitiesList> list;

  WeatherCoord({
    this.message, this.count, this.list,
  });

  factory WeatherCoord.fromJson(Map<String, dynamic> json) {
    var listCities = json['list'] as List;
    List<CitiesList> citiesList = listCities.map((i) => CitiesList.fromMap(i)).toList();

    return WeatherCoord(
      list: citiesList,
      count: json['count'],
      message: json['message'],
    );
  }
}
//class CitiesList {
//  final int id;
//  final String name;
//  DataMain main;
//  DataSys sys;
//
//  CitiesList({this.id, this.name, this.sys, this.main,});
//
//  factory CitiesList.fromMap(Map<String, dynamic> json) => CitiesList(
//    id: json["id"],
//    name: json["name"],
//    main: DataMain.fromMap(json["main"]),
//    sys: DataSys.fromJson(json["sys"]),
//  );
//}

class CitiesList {
  final int id;
  final String name;
  DataMain main;
  DataSys sys;
  final List<WeatherList> weather;

  CitiesList({this.id, this.name, this.sys, this.main, this.weather});

  factory CitiesList.fromMap(Map<String, dynamic> json){
    var listWeather = json['weather'] as List;
    List<WeatherList> weatherList = listWeather.map((i) => WeatherList.fromMap(i)).toList();
    return CitiesList(
      id: json["id"],
      name: json["name"],
      main: DataMain.fromMap(json["main"]),
      sys: DataSys.fromJson(json["sys"]),
      weather: weatherList,
    );
  }
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

class DataSys {
  final String country;

  DataSys({this.country});

  factory DataSys.fromJson(Map<String, dynamic>parseJson) => DataSys(
    country: parseJson["country"],
  );
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