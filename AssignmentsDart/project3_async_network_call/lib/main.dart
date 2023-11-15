import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String URL = 'jsonplaceholder.typicode.com';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  

  String? response;
  TextEditingController inputController = TextEditingController();
  Color color_ = Colors.yellow;
  int responseStatus = -1;
  bool didGetResponseFlag = false;
  int progressBarVisibilityCode = -1;
  //-1 -> initstate
  //0->loading
  //1->got response

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Network-Call',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                response ?? 'Response here',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: ElevatedButton(
                  onPressed: () async {
                    if (inputController.text.isNotEmpty &&
                        isNumber(inputController.text)) {
                      didGetResponseFlag = false;
                      progressBarVisibilityCode =
                          0; //sets the visibility of progressbar
                      setState(() {});

                      String requestedId = (inputController.text);

                      Future<String> tempString =
                          Future.delayed(const Duration(seconds: 3), () {
                        return makeNetworkCall(requestedId);
                      });

                      tempString.then((value) {
                        didGetResponseFlag = true;
                        progressBarVisibilityCode = 1;
                        response = value;

                        if (responseStatus >= 100 && responseStatus <= 199) {
                          debugPrint('Informational status');
                          color_ = Colors.orangeAccent;
                        } else if (responseStatus >= 200 &&
                            responseStatus <= 299) {
                          debugPrint('Successful responses');
                          color_ = Colors.green;
                        } else if (responseStatus >= 300 &&
                            responseStatus <= 399) {
                          debugPrint('Redirection message');
                          color_ = Colors.brown;
                        } else if (responseStatus >= 400 &&
                            responseStatus <= 499) {
                          debugPrint('Client error messages');
                          color_ = Colors.indigo;
                        } else if (responseStatus >= 500 &&
                            responseStatus <= 599) {
                          debugPrint('Server error Responses');
                          color_ = Colors.red;
                        }
                        setState(() {});
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Invalid type input!'),
                        duration: Duration(seconds: 2),
                      ));
                    }

                    //response = await tempString;

                    // response = await makeNetworkCall(1);
                  },
                  child: Text('click')),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(8),
              child: Visibility(
                visible: (progressBarVisibilityCode == -1 ||
                        progressBarVisibilityCode == 1)
                    ? false
                    : true,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.amber,
                  backgroundColor: Colors.deepOrange,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Visibility(
                visible: (didGetResponseFlag == false) ? false : true,
                child: Icon(
                  Icons.circle,
                  size: 40,
                  color: color_,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: inputController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 4.0,
                            style: BorderStyle.solid,
                            color: Colors.deepPurpleAccent)),
                    hintText: 'Type Request ID , eg - 1',
                    labelText: 'Type id',
                    labelStyle: TextStyle(color: Colors.deepPurple)),
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ));
  }

  Future<String> makeNetworkCall(String requestId) async {
    Uri uri_obj = Uri.https(URL, '/todos/$requestId');
    http.Response response = await http.get(uri_obj);
    debugPrint(response.body);
    responseStatus = response.statusCode;
    var items = jsonDecode(response.body);
    debugPrint(items['title']);
    return response.body;
  }

  bool isNumber(String input) {
    bool flag = true;

    // abcd12
    /*
    for (int i = 0; i < input.length; i++) {
      if (int.parse(input[i]) >= 0 && int.parse(input[i]) <= 9)
        ;
      else {
        flag = false;
      }
    }
    */

    int result = -1;
    try {
      result = int.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  }
}
