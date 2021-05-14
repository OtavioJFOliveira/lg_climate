import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:lg_climate/Screens/Place.dart';
import 'package:lg_climate/Screens/SendToLGPage.dart';
import 'package:lg_climate/Screens/NetworkInfo.dart';
import 'package:lg_climate/Screens/exemploLocalizacao.dart';

import 'Screens/WeatherForecastPage.dart';
import 'Screens/pageTest.dart';

void main() { runApp(MyApp());}

var _indiceAtual = 0;
var title = "";
class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    WeatherForecast.tag:(context) => WeatherForecast(),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LG Climate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: _Screens(_indiceAtual),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _indiceAtual,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                 icon: Icon(Icons.brightness_4),
                 title: Text("Weather Forecast")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_to_home_screen),
                   title: Text("Liquid Galaxy")
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
          ]
        )
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _indiceAtual = value;
    });
  }

  _Screens(indiceAtual) {
    if(_indiceAtual == 1)
    {
     // title = CityName;
      //return MyApp2();
      //return HomePage1();
      return GeolocatorWidget();
    }
    else{
      //title = "Send info to LG";
      return WeatherForecast();
    }
  }
}
