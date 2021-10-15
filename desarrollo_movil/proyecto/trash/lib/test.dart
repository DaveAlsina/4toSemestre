import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CustomData extends StatefulWidget {
  CustomData({Key? key, required this.app}) : super(key: key);
  final FirebaseApp app;

  @override
  _CustomDataState createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {


  final referenceDatabase = FirebaseDatabase.instance;
  final userName = 'Nombre de Usuario';
  final email = 'XXXXX@XXXX.com';

  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final ref = referenceDatabase.reference();

    return Scaffold(
        appBar: AppBar(
          title: Text("FIREBASE DATABASE TEST"),
        ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Center(
            child: Container(
              color: Colors.white54,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  //display del nombre del usuario, y su correo (pronto imagen también)
                  Text(userName, textAlign: TextAlign.center),
                  Text(email, textAlign: TextAlign.center),

                  //campos para escribir el nuevo nombre de usuario
                  TextField(
                    controller: userNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nuevo nombre de usuario',
                    ),
                  ),

                  //botón para ir a campo de actualización de datos personales de usuario
                  TextButton(onPressed: (){
                    ref.child('Usuarios')
                        .push()
                        .child(userName)
                        .set(userNameController.text)
                        .asStream();
                    userNameController.clear();
                  },
                    child: Text("Actualizar información"),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    )
    );
  }
}
