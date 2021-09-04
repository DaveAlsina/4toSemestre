import 'package:flutter/material.dart';
import 'example1.dart';
import 'example2.dart';
import 'example3.dart';
import 'example4.dart';

void main() {
  //Example 1
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));

  /* //Example 2
  runApp(MaterialApp(
    title: 'Navigation Basics',
    //home: FirstRoute(), //Example 1
    initialRoute: '/', //Example 2
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => const FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => const SecondScreen(),
    },
  ));
*/

/* //Example 3
  runApp(const MyApp());
*/

/*//Example 4
  runApp(
    const MaterialApp(
      title: 'Returning Data',
      home: HomeScreen2(),
    ),
  );

*/
}
