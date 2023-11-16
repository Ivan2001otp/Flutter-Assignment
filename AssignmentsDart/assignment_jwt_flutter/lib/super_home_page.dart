import 'package:assignment_jwt_flutter/Database/shared_preferences_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuperHomePage extends StatelessWidget {
  SharedPrefsManager sharedPrefsManager = SharedPrefsManager();

  bool isLogout = true;

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to log out'),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  onPressed: () {
                    isLogout = true;
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge),
                  onPressed: () {
                    isLogout = false;
                    Navigator.pop(context);
                  },
                  child: Text('No'))
            ],
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (isLogout == true) {
      //logged in
      isLogout = false;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              print('pressed on logout');
              final SharedPreferences prefs = await sharedPrefsManager.prefs;
              print(prefs.getString('name'));
              print(prefs.getString('id'));
              print(prefs.getString('token'));
              print(prefs.getString('email'));
              print('logout');

              await _dialogBuilder(context);
              if (isLogout) {
                //print('your are logged out');

                prefs.remove('name');
                prefs.remove('id');
                prefs.remove('token');
                prefs.remove('email');

                prefs.clear();

                Navigator.of(context).pushReplacementNamed('/');
              } else {
                print('you are not logged out');
              }
            },
            icon: Icon(Icons.logout_outlined)),
        elevation: 0,
        title: Text('Ultra Home Page'),
      ),
      body: Center(child: Text('Hi bro this is home page')),
    );
  }
}
