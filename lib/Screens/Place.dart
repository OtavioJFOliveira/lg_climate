//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:geolocator/geolocator.dart';
//
//class HomePage1 extends StatefulWidget {
//  @override
//  _HomePageState1 createState() => _HomePageState1();
//}
//
//class _HomePageState1 extends State<HomePage1> {
//  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//
//  Position _currentPosition;
//  String _currentAddress;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Location"),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            if (_currentPosition != null) Text(_currentAddress),
//            if (_currentPosition != null) Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
//            FlatButton(
//              child: Text("Get location"),
//              onPressed: () {
//                if(geolocator.isLocationServiceEnabled() == true)
//                _getCurrentLocation();
//                else
//                  print("Geolocalização desligado");
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  _getCurrentLocation() {
//    geolocator
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//        .then((Position position) {
//      setState(() {
//        _currentPosition = position;
//        print(_currentPosition);
//      });
//
//      _getAddressFromLatLng();
//    }).catchError((e) {
//      print(e);
//    });
//  }
//
//  _getAddressFromLatLng() async {
//    try {
//      List<Placemark> p = await geolocator.placemarkFromCoordinates(
//          _currentPosition.latitude, _currentPosition.longitude);
//
//      Placemark place = p[0];
//
//      setState(() {
//        _currentAddress =
//        "${place.locality}, ${place.postalCode}, ${place.country}";
//      });
//    } catch (e) {
//      print(e);
//    }
//  }
//}