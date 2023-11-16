import 'package:assignment_jwt_flutter/Database/shared_preferences_flutter.dart';
import 'package:assignment_jwt_flutter/login_page.dart';
import 'package:assignment_jwt_flutter/register_page.dart';
import 'package:assignment_jwt_flutter/super_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: HomePage(),
    initialRoute: '/',
    routes: {
      "/": (context) => LoginPage(),
      // "/login": (context) => LoginPage(),
      "/register": (context) => RegisterPage(),
      "/home": (context) => SuperHomePage()
    },
  ));
}

/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<SharedPreferences> initiateSharedPreference() async {
  SharedPrefsManager sharedPrefsManager = SharedPrefsManager();
  SharedPreferences prefs = await sharedPrefsManager.prefs;
  return prefs;
}

class _HomePageState extends State<HomePage> {
  SharedPrefsManager sharedPrefsManager = SharedPrefsManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Backend-test-jwt'),
      ),
      body: FutureBuilder(
          future: initiateSharedPreference(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final prefs = snapshot.data;

              String? token = prefs?.getString('token');
              print(token);

              if (token != null) {
                Navigator.of(context).pushReplacementNamed('/home');
              } else {
                return Container(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => LoginPage())));
                          },
                          child: Text('Login'))
                    ],
                  ),
                );
              }
            }
            if (ConnectionState.waiting == snapshot.connectionState) {
              return CircularProgressIndicator();
            }
            return Center(
              child: Text('something went wrong!'),
            );
          })),
    );
  }
}
*/