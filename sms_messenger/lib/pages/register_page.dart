import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sms_messenger/components/my_button.dart';
import 'package:sms_messenger/components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                hintText: 'UserName',
                isObscureText: false,
                controller: TextEditingController()),
          ),
          Gap(10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: MyTextField(
                hintText: 'Email',
                isObscureText: true,
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
            child: MyButton(onPressed: () {}, buttonText: 'Register'),
          ),
          Gap(20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a member?',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Gap(10),
                TextButton(
                  onPressed: () {
                    print('Register pressed!');

                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: Text(
                    'Login Here',
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
