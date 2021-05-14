import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lg_climate/Widgets/SearchByCity.dart';
import 'package:lg_climate/Widgets/SearchByGeoposition.dart';
import 'WeatherForecastPage.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

var control =0;

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SearchPage> {
  Future<WeatherCity> futureWeatherCity;
  Future<WeatherCoord> futureWeatherCoord;

  final SearchBox = TextEditingController();
  final _SearchKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureWeatherCity = fetchWeatherCity();
    futureWeatherCoord = fetchWeatherCoord();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width*.98,
                  height: size.height*.1,
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Form(
                          key: _SearchKey,
                          child: Center(
                            child: Container(
                              width: size.width*.8,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                validator: (value){
                                  if(value.isEmpty) return "This info is mandatory";
                                  return null;
                                },
                                controller: SearchBox,
                                decoration: InputDecoration(
                                  labelText: "Search city",
                                  labelStyle: TextStyle(color: Colors.black87),
                                  contentPadding: EdgeInsets.fromLTRB(30, 10,20, 10),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),

                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.search),
                            onPressed: (){
                              control = 1;
                              FocusScope.of(context).requestFocus(new FocusNode());
                              setState(() {
                                 City = SearchBox.text;
                               // decodifica(SearchBox.text);
                                SearchBox.clear();
                                 futureWeatherCity = fetchWeatherCity();
                              });
                            }
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width*.98,
                  height: size.height*.1,
                  child: Card(
                    child: RaisedButton(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on,color: Colors.black45,),
                          Text("Find my location")
                        ],
                      ),
                      onPressed: (){
                        control = 2;
                        setState(() {
                          futureWeatherCoord = fetchWeatherCoord();
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  height: size.height*.02,
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if(control == 1)
                      FutureBuilder<WeatherCity>(
                        future: futureWeatherCity,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            control = 0;
                            return
                            Container(
                              width: size.width*.98,
                              height: size.height*.1,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFDCDCDC),width: 3),
                                    borderRadius: BorderRadius.circular(5)),
                                child: RaisedButton(
                                  color: Colors.white,
                                  child: ListTile(
                                    leading:
                                    Image(image: NetworkImage('http://openweathermap.org/img/wn/'+ snapshot.data.weather[0].icon+'@2x.png')),
                                    title: Text(snapshot.data.name+ " - " + snapshot.data.sys.country,style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),),
                                    subtitle: Text("Temp Max: " + snapshot.data.main.tempMax.toString() + "°" +
                                        "\nFeels Like:  " + snapshot.data.main.feelsLike.toString() + "°"),
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      CityName = snapshot.data.name;
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>WeatherForecast()),(Route<dynamic> route) => false);
                                  },
                                ),
                              ),
                            );
                              Text(snapshot.data.name+ " - "+snapshot.data.sys.country);
                          } else if (snapshot.hasError) {
                            control = 0;
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                      if(control == 2)
                        FutureBuilder<WeatherCoord>(
                          future: futureWeatherCoord,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              control = 0;
                              return
                                Container(
                                  width: size.width*.98,
                                  height: size.height*.64,
                                  child: ListView.builder(
                                      itemCount: snapshot.data.count,
                                      itemBuilder: (context, int index){
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(color: Color(0xFFDCDCDC),width: 3),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: RaisedButton(
                                          color: Colors.white,
                                          child: ListTile(
                                            leading:
                                            Image(image: NetworkImage('http://openweathermap.org/img/wn/'+ snapshot.data.list[index].weather[0].icon+'@2x.png')),
                                            title: Text(snapshot.data.list[index].name+ " - " + snapshot.data.list[index].sys.country,style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700
                                            ),),
                                            subtitle: Text("Temp Max: " + snapshot.data.list[index].main.tempMax.toString() + "°" +
                                                "\nFeels Like:  " + snapshot.data.list[index].main.feelsLike.toString() + "°"),
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              CityName = snapshot.data.list[index].name;
                                            });
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>WeatherForecast()),(Route<dynamic> route) => false);
                                          },
                                        ),
                                      );
                                      },
                                  )
                                );
                              //Text(snapshot.data.name+ " - "+snapshot.data.sys.country);
                            } else if (snapshot.hasError) {
                              control = 0;
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




































