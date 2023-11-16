import 'package:flutter/rendering.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? token;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.token});

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.email = map['email'];
    this.token = map['token'];
  }
}
