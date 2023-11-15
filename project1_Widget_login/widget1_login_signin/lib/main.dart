import 'package:flutter/material.dart';

void main() {
  runApp(myFlutterApp());
}

class myFlutterApp extends StatefulWidget {
  @override
  State<myFlutterApp> createState() => _myFlutterAppState();
}

class _myFlutterAppState extends State<myFlutterApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen & Sign Up',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  var firstNameInputController = TextEditingController();
  var lastNameInputController = TextEditingController();
  var emailInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          title: Text('Login Screen'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)))),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Login Page',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: Colors.red),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 15),
              padding: EdgeInsets.all(5),
              child: TextField(
                maxLength: 20,
                keyboardType: TextInputType.name,
                controller: firstNameInputController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'First-Name',
                    hintText: 'For example : Ivan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 8),
              padding: EdgeInsets.all(5),
              child: TextField(
                maxLength: 20,
                keyboardType: TextInputType.name,
                controller: lastNameInputController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_3),
                    labelText: 'Last Name',
                    hintText: 'For example : Roy',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 8),
              padding: EdgeInsets.all(5),
              child: TextField(
                maxLength: 20,
                keyboardType: TextInputType.emailAddress,
                controller: emailInputController,
                decoration: InputDecoration(
                    hintText: 'abcd212@gmail.com',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 22),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)))),
                      onPressed: () {
                        String fname =
                            firstNameInputController.value.text ?? "";
                        String lname = lastNameInputController.value.text ?? "";
                        String email = emailInputController.value.text ?? "";

                        if (!fname.isEmpty &&
                            !lname.isEmpty &&
                            !email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              displaySnackBar(
                                  fname + "-" + lname + "-" + email));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(displaySnackBar('Empty Fields.'));
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                )),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: Text('Create Account')))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(6),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 3)),
                      child: IconButton(
                          onPressed: () {
                            // displaySnackBar('Google');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(displaySnackBar('Google'));
                          },
                          icon: Image.asset('assets/images/google.png'))),
                  Container(
                    margin: EdgeInsets.all(6),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 3)),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(displaySnackBar('Twitter'));
                      },
                      icon: Image.asset('assets/images/twitter.png'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SnackBar displaySnackBar(String message) {
    print('clicked ${message}\n');
    final snackBarObject = SnackBar(
      dismissDirection: DismissDirection.startToEnd,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      content: Text(
        message,
        style: const TextStyle(color: Colors.yellow, fontSize: 15),
      ),
      duration: Duration(seconds: 2),
    );

    return snackBarObject;
  }
}
