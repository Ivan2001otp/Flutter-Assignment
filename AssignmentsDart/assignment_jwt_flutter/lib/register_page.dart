import 'dart:convert';

import 'package:assignment_jwt_flutter/Database/shared_preferences_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DioService {
  //  String URL = 'http://localhost:4000/api/users';

/*
  static Dio dioInstance = Dio(BaseOptions(
      baseUrl: 'http://localhost:4000/api/users/',
      responseType: ResponseType.json));
      */

  static Dio dioInstance = Dio();

  static Future<dynamic> registerEndPoint(
      String u_name, String u_email, String u_password) async {
    Map<String, dynamic> map = {
      'name': u_name,
      'email': u_email,
      'password': u_password
    };

/*
    final uri_ = Uri.parse('http://localhost:4000/api/users/');

    http.Response response = await http.post(uri_,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "name": u_name,
          "email": u_email,
          "password": u_password
        }));

    print(response.body);

    if (response.statusCode == 201) {
      print('successfully posted\n');
    } else {
      print('post protocol failed');
    }
    */

    try {
      print('response - 1');
      Response response = await dioInstance.post(
          'http://localhost:4000/api/users/',
          data: map,
          options: Options(responseType: ResponseType.json));
      print('response - 2');

      print(response.statusCode);

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
          'http://localhost:4000/api/users/login',
          data: map,
          options: Options(responseType: ResponseType.json));

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
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
        title: Text('Authenticate'),
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
                    final sharedPreferences =
                        SharedPreferenceEntity.getPreferenceDB();

                    if (nullEmptyChecker(username) &&
                        nullEmptyChecker(pass) &&
                        nullEmptyChecker(uemail)) {
                      bool result = await DioService.registerEndPoint(
                          username, uemail, pass);
                      print(result);

                      if (result) {
                        /*
                        await sharedPreferences.then((value) => null)//.setString('name', username);
                        sharedPreferences.setString('email', uemail);
                        sharedPreferences.setString('password', pass);
                        */

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Posted Successfully'),
                          duration: Duration(seconds: 2),
                        ));
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
            )
          ],
        ),
      ),
    );
  }
}
