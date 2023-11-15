import 'package:assignment_jwt_flutter/login_page.dart';
import 'package:assignment_jwt_flutter/register_page.dart';
import 'package:flutter/material.dart';
import './register_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => RegisterPage())));
                },
                child: Text('Register')),
            ElevatedButton(onPressed: () {}, child: Text('Get-Me')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginPage())));
                },
                child: Text('Login'))
          ],
        ),
      ),
    );
  }
}
