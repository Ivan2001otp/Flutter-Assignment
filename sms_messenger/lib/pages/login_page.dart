import 'package:flutter/material.dart';
import 'package:sms_messenger/components/my_button.dart';
import '../components/my_text_field.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Icon(
              Icons.chat_bubble_rounded,
              size: 100,
              color: Colors.black38,
            ),
          ),
          Gap(40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: MyTextField(
                hintText: 'Email',
                isObscureText: false,
                controller: TextEditingController()),
          ),
          Gap(10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: MyTextField(
                hintText: 'Password',
                isObscureText: true,
                controller: TextEditingController()),
          ),
          Gap(20),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            child: MyButton(
                onPressed: () {
                  print('Login');
                },
                buttonText: 'Login'),
          ),
          Gap(20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do not have an Account?',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Gap(10),
                TextButton(
                  onPressed: () {
                    print('register Here!');
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  child: Text(
                    'Register Here',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
