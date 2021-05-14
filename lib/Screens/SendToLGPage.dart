import 'package:flutter/material.dart';

import 'NetworkInfo.dart';

class SendToLG  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Send info to LG"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings, color: Colors.white,),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NetInfoPage()));
              }
          )
        ],
      ),
      body:
       Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height*.20,
              ),
              Container(
                width: size.width*.8,
                child: Center(
                  child: Text("Do you want to send this info to \n  Liquid Galaxy?", textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.black87,fontSize: 28,fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                height: size.height*.10,
              ),
              Container(
                  width: size.width*.6,
                  height: 50,
                  color: Colors.white,
                  child: RaisedButton(
                      child: Text("Yes, Send!", style: TextStyle(
                          color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),
                      ),
                      color: Colors.blue,
                      onPressed: (){

                      }
                  )
              ),
            ],
          ),
        ),
      ),
    );

  }
}