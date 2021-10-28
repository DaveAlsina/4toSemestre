import 'package:get/get.dart';
import 'package:agro_a_la_mano_dev/data/models/userModel.dart';

class DatabaseConnection {
  bool userAuth = true;

  bool registerUser(String name, String email, String password){

    return userAuth;
  }

}

class UserController extends GetxController{

  DatabaseConnection database = DatabaseConnection();
  var usr = <UserModel>[].obs();

  //getters

  String get name => usr.isEmpty? '' : usr[0].name;
  String get email => usr.isEmpty? '' : usr[0].email;
  String get password => usr.isEmpty? '' : usr[0].password;

  //setters

  set name(String newName) => usr[0].name = newName;
  set email(String newEmail) => usr[0].name = newEmail;


  /*
      Input:  String name     -> nombre del usuario
              String email    -> correo del usuario
              String password -> contraseña del usuario

      Output: bool (en caso de añadir al usuario exitosamente manda true,
              de lo contrario manda false)
   */

  bool addNewUser(String name, String email, String password){

      //añade al usuario a la lista de usuarios
      usr.add(UserModel());
      usr[0].addInfo(name, email, password);

      bool registration = database.registerUser(name, email, password);

      //si el registro fue exitoso mantiene los datos del potencial usuario en la lista
      //de lo contrario los borra
      if (!registration){

        usr.clear();
        return false;
      }

      return true;
  }

  String toString(){

     if (usr.isEmpty) {
       return '';
     }

     //print(usr[0].toString());
     return usr[0].toString();
  }

  //setters
  bool changeName(String newName){

      if(usr.isEmpty){
        return false;
      }

      usr[0].name = newName;
      print(newName);
      return true;

  }



}