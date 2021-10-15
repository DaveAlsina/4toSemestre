import 'dart:core';
import 'package:get/get.dart';


class UserModel {

  final int id;
  final String name;
  final String email;
  final String picture;
  final String password;

 UserModel({
   required this.id,
   required this.name,
   required this.email,
   required this.picture,
   required this.password,
  });


 /* getters */

  int getId() => id;
  String getName() => name;
  String getEmail() => email;
  String getPicture() => picture;
  String getPassword() => password;

  Map<String, dynamic> toMap() {
      return {
        'id': id,
        'name': name,
        'email': email,
        'picture': picture,
        'password': password,
      };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, picture : $picture, password: $password}';
  }

}
