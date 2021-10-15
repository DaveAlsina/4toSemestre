import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp();

  runApp(MaterialApp(
    home:MyApp(app: app)
  ));

}


class MyApp extends StatelessWidget {

  MyApp({Key? key, required this.app}) : super(key: key);
  final FirebaseApp app;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomData(app: app),
    );
  }

}

