import 'package:flutter/material.dart';
import 'dart:async';


class  SecondRoute extends StatefulWidget {
  // This widget is the root of your application.

  SecondRoute({Key? key, required this.count}) : super(key: key);
  int count;

  @override
  _SecondRouteState createState() => _SecondRouteState(counter:count);
}

class _SecondRouteState extends State<SecondRoute> {

  _SecondRouteState({required this.counter});
  int counter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de factorial',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SecondRouteHomePage(counter:counter),
    );
  }
}

class SecondRouteHomePage extends StatefulWidget{

  SecondRouteHomePage({Key? key, required this.counter}) : super(key: key);
  int counter;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _SecondRouteHomePageState createState() => _SecondRouteHomePageState(counter:counter);
}

class _SecondRouteHomePageState extends State<SecondRouteHomePage> {

  _SecondRouteHomePageState({required this.counter});
  int counter;
  int _ans = 1;
  int passVal =0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    });
  }


  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$counter!',
              style: Theme.of(context).textTheme.headline4,
            ),

            Container(height: 100,),

            Row(
              children: [
                Expanded(child:
                ElevatedButton(       //bot??n de evaluar fact. operaci??n y regresar
                  onPressed: (){
                    setState(() {
                      int passVal = _ans * counter;
                    });

                      Navigator.pop(context, this.passVal);
                  },
                  child: Icon(Icons.done_rounded),
                ),
                ),

                Container(width: 50,),

                Expanded(child:
                ElevatedButton(
                  onPressed: ()async{

                    counter++;
                    final currAns = await Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SecondRoute(count: counter)));

                    setState(() {
                      print('AAAAAAAAAAAA');
                      _ans = currAns;
                      counter = counter;
                    });

                  },
                  child: Icon(Icons.add),
                ),
                ),

              ],
            )
          ],

        ),
      ),


    );
  }
}
