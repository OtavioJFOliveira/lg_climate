import 'package:flutter/material.dart';
import 'package:lg_climate/Screens/Place.dart';
import 'package:lg_climate/Screens/SearchPage.dart';
import 'package:lg_climate/Screens/pageTest.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'NetworkInfo.dart';

var CityName = "";

String APIURL = "http://api.openweathermap.org/data/2.5/weather?q=";
String City = "";
String lat = "";
String lon = "";
String key = "&appid=cb4cdffe3acbf2d5737110869c84b7c5";

class WeatherForecast extends StatefulWidget{
  static final tag = 'WeatherForecast-page';

  WeatherForecast({Key key}) : super(key: key);

  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  final SearchBox = TextEditingController();
  final _SearchKey = GlobalKey<FormState>();

  //Future<Weather> futureWeather;

  @override
  void dispose() {
    SearchBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(CityName),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings, color: Colors.white,),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchPage()));
              }
          )
        ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.orange,
          child: Column(
            children: <Widget>[

              Container(
                //color: Colors.white,
                width: size.width,
                height: size.height*0.10,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width*0.02,
                    ),
                    Form(
                      key: _SearchKey,
                      child: Container(
                        width: size.width*.80,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if(value.isEmpty) return "This info is mandatory";
                            return null;
                          },
                          controller: SearchBox,
                          decoration: InputDecoration(
                            labelText: "Search",
                            labelStyle: TextStyle(color: Colors.black87),
                            contentPadding: EdgeInsets.fromLTRB(30, 10,20, 10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),

                          ),
                        ),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.send),
                        onPressed: (){
                          FocusScope.of(context).requestFocus(new FocusNode());
                          setState(() {
                            // City = SearchBox.text;
                            decodifica(SearchBox.text);
                            SearchBox.clear();
                            //  futureWeather = fetchWeather();
                          });
                        }
                    )
                  ],
                ),
                //width: double.infinity,
              ),
              Center(
                child: IconButton(icon: Icon(Icons.send),
                    onPressed: (){
                      setState(() {
                        CityName;
                      });
                    }
                ),
//                child: FutureBuilder<Weather>(
//                  future: futureWeather,
//                  builder: (context, snapshot) {
//                    if (snapshot.hasData) {
//                      CityName = snapshot.data.name;
//                      return Text(snapshot.data.id.toString());
//
//                    } else if (snapshot.hasError) {
//                      CityName = "Error indicate a city";
//                      return Text("Error indicate a city");
//                    }
//                    // By default, show a loading spinner.
//                    return CircularProgressIndicator();
//                  },
//                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

