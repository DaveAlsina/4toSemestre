
import 'package:agro_a_la_mano_dev/data/controllers/userController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {

  runApp(MaterialApp(
    //home:TestUserModel(),
    home:TestUserController(),
  ));

}


class TestUserController extends StatelessWidget {
  TestUserController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController usr = Get.find<UserController>();

    return GetMaterialApp(
      home: Scaffold(
            body: Center(
              child: Column(
                  children: <Widget>[
                    Text("Informacion del usuario: "),
                    Text(usr.toString()),
                    SizedBox(height: 20,),

                    Obx(() => Text(usr.toString())),
                    //Text("El nombre es: " + usr.name),
                    SizedBox(height: 20,),

                    TextButton(onPressed: (){
                        usr.addNewUser('Dave', 'PrettyBoyBabe', 'plzWork:c');
                        print(usr.toString());
                    }, child: Text('Clicameeee!')),

                  ],
              ),
            ),
      ),
    );
  }
}
