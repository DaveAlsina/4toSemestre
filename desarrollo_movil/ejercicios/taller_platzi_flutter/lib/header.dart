import 'package:flutter/material.dart';
import 'backWeather.dart'


class Header extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      body: new Stack(
          children: <Widget>[
            new BackWheather()
          ],
      ),

    );
  }

}
