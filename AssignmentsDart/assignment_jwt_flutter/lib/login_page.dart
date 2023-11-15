import 'package:assignment_jwt_flutter/Database/shared_preferences_flutter.dart';
import 'package:assignment_jwt_flutter/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool nullEmptyChecker(String resource) {
    if (resource != null && !resource.isEmpty) return true;
    return false;
  }

  void displaySnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

  final sharedPrefs = SharedPreferenceEntity.getPreferenceDB();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Login Details',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
            child: TextField(
              controller: mailController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: 'Email - abc@gmail.com',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: TextField(
              controller: passController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  hintText: 'Password - ***',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: SizedBox(
              width: 100,
              height: 45,
              child: ElevatedButton(
                  onPressed: () async {
                    debugPrint('login clicked');

                    var email = mailController.text;
                    var pass = passController.text;

                    if (nullEmptyChecker(email) && nullEmptyChecker(pass)) {
                      bool result = await DioService.loginEndPoint(email, pass);
                      if (result) {
                        displaySnackBar('Successfully Logged In', context);
                      } else {
                        displaySnackBar(
                            'Make sure you have registered first!', context);
                      }
                    } else {
                      displaySnackBar('Empty Fields', context);
                    }
                  },
                  child: Text('Login')),
            ),
          ),
          /*
          Container(
            child: Text(sharedPrefs.getString('name') ?? 'Last register name'),
          ),
          Container(
            child:
                Text(sharedPrefs.getString('email') ?? 'Last registered email'),
          ),
          Container(
            child: Text(sharedPrefs.getString('password') ??
                'Last registered password'),
          )
          */
        ],
      ),
    ));
  }
}
