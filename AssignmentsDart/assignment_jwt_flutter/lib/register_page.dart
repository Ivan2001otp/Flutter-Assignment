import 'dart:convert';

import 'package:assignment_jwt_flutter/Database/shared_preferences_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/user.dart';

class DioService {
  static Dio dioInstance = Dio();

  static Future<dynamic> registerEndPoint(
      String u_name, String u_email, String u_password) async {
    Map<String, dynamic> temp_map = {
      'name': u_name,
      'email': u_email,
      'password': u_password
    };

    try {
      print('response - 1');
      Response response = await dioInstance.post(
          'http://192.168.199.1:4000/api/users/',
          data: temp_map,
          options: Options(responseType: ResponseType.json));
      print('response - 2');

      print(response.statusCode);
      print(response.data);
      Map<String, dynamic> map = response.data;

      print(map['id']);
      print(map['name']);
      print(map['email']);
      print(map['token']);

      final sharedPreferences = SharedPrefsManager();
      final SharedPreferences dbHandler = await sharedPreferences.prefs;

      dbHandler.setString('name', map['name']);
      dbHandler.setString('id', map['id']);
      dbHandler.setString('email', map['email']);
      dbHandler.setString('token', map['token']);

      print('${dbHandler.getString('name')} - ${dbHandler.getString('token')}');
      dbHandler.clear();
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<dynamic> loginEndPoint(String email, String password) async {
    Map<String, dynamic> map = {'email': email, 'password': password};

    try {
      Response response = await dioInstance.post(
          'http://192.168.199.1:4000/api/users/login',
          data: map,
          options: Options(responseType: ResponseType.json));

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print(response.data);

        final sharedPreferences = SharedPrefsManager();
        final SharedPreferences dbHandler = await sharedPreferences.prefs;
        Map<String, dynamic> tempMap = response.data;

        dbHandler.setString('name', tempMap['name']);
        dbHandler.setString('id', tempMap['id']);
        dbHandler.setString('email', tempMap['email']);
        dbHandler.setString('token', tempMap['token']);

        return true;
      } else {
        debugPrint('Error happened while login in try - block!');
      }
    } catch (e) {
      return false;
    }
  }
}

class RegisterPage extends StatelessWidget {
  TextEditingController unameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool nullEmptyChecker(String resource) {
    if (resource != null && !resource.isEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Registration Protocol'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: TextField(
                controller: unameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: 'Email - abc@gmail.com',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: TextField(
                controller: passController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    hintText: 'password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              child: SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  child: Text('Post'),
                  onPressed: () async {
                    final username = unameController.text;
                    final pass = passController.text;
                    final uemail = emailController.text;
                    final sharedPreferences = SharedPrefsManager();
                    final dbHandler = await sharedPreferences.prefs;

                    if (nullEmptyChecker(username) &&
                        nullEmptyChecker(pass) &&
                        nullEmptyChecker(uemail)) {
                      bool result = await DioService.registerEndPoint(
                          username, uemail, pass);
                      print(result);

                      if (result) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Posted Successfully'),
                          duration: Duration(seconds: 2),
                        ));
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Post Request Failed'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Empty fields.'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                ),
              ),
            ),
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: Text(
                    'Login Page',
                    style: TextStyle(color: Colors.green),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
