import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  //final database = FirebaseDatabase.instance.reference();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba Firebase'),
      ),
      body: Column(
        children: [
          TextField(controller: messageController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '¿Qué tienes por decirnos o por preguntar?'
                    ),
          ),

        ],
      ),
    );
  }
}


void main(){
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
