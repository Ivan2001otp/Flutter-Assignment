import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String URL = 'jsonplaceholder.typicode.com';

void main() {
  runApp(MaterialApp(
    home: FutureApp(),
  ));
}

class FutureApp extends StatefulWidget {
  @override
  State<FutureApp> createState() => FutureAppState();
}

String? requestId;
int requestStatusCode = -1;

Future<String> networkResponseFuture = makeNetworkCall(requestId);

class FutureAppState extends State<FutureApp> {
  @override
  Widget build(BuildContext context) {
    String textToDisplay = 'Response Here';
    Color roundColourIcon = Colors.black;

    TextEditingController inputController = TextEditingController();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Future Builder',
          style: TextStyle(),
        ),
      ),
      body: FutureBuilder<String>(
          future: networkResponseFuture,
          builder: ((context, snapshot) {
            //List<Widget> children_ = [];

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Colors.orange,
                    ),
                  ),
                );

              case ConnectionState.done:
                if (snapshot.hasData) {
                  //status is successful
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          snapshot.data ?? 'Response Here',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                      Visibility(
                        visible: roundColourIcon == Colors.black ? false : true,
                        child: Container(
                          margin: EdgeInsets.all(15),
                          child: Icon(
                            Icons.circle,
                            size: 40,
                            color: roundColourIcon,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          controller: inputController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 4.0,
                                      style: BorderStyle.solid,
                                      color: Colors.deepPurpleAccent)),
                              hintText: 'Type request ID',
                              labelText: 'Type id',
                              labelStyle: TextStyle(color: Colors.deepPurple)),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                            onPressed: () async {
                              String res = inputController.text;

                              if (res != null &&
                                  res.isNotEmpty &&
                                  isNumber(res)) {
                                networkResponseFuture =
                                    makeNetworkCall(inputController.text);

                                print(networkResponseFuture);
                                setState(() {
                                  networkResponseFuture.then((response) {
                                    textToDisplay = response.isEmpty
                                        ? 'Response Here is Empty'
                                        : response;
                                  });
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Invalid Input text'),
                                  duration: Duration(seconds: 3),
                                ));
                              }

                              /*
                              String inputRequestId = inputController.text;
                              if (inputRequestId.isNotEmpty &&
                                  inputRequestId != null &&
                                  isNumber(inputRequestId)) {
                                debugPrint('Clicked for API ' + inputRequestId);

                                networkResponseFuture.then((response) {
                                  // debugPrint('inside the response!');
                                  print('empty : $response');

                                  textToDisplay = response; //get the text
                                  debugPrint(textToDisplay);

                                  if (requestStatusCode >= 100 &&
                                      requestStatusCode <= 199) {
                                    roundColourIcon = Colors.yellow;
                                  } else if (requestStatusCode >= 200 &&
                                      requestStatusCode <= 299) {
                                    roundColourIcon = Colors.green;
                                  } else if (requestStatusCode >= 300 &&
                                      requestStatusCode <= 399) {
                                    roundColourIcon = Colors.indigo;
                                  } else if (requestStatusCode >= 400 &&
                                      requestStatusCode <= 499) {
                                    roundColourIcon = Colors.purple;
                                  } else if (requestStatusCode >= 500 &&
                                      requestStatusCode <= 599) {
                                    roundColourIcon = Colors.red;
                                  }

                                  //  setState(() {});
                                }
                                
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Invalid text input!'),
                                  duration: Duration(seconds: 3),
                                ));
                              }

                              */
                            },
                            child: Text(
                              'Click',
                              style: TextStyle(fontSize: 15),
                            )),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Error Occured!',
                          style: TextStyle(fontSize: 10, color: Colors.red),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Icon(
                          Icons.circle,
                          size: 40,
                          color: roundColourIcon,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(6),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 4.0,
                                      style: BorderStyle.solid,
                                      color: Colors.deepPurpleAccent)),
                              hintText: 'Type request ID',
                              labelText: 'Type id',
                              labelStyle: TextStyle(color: Colors.deepPurple)),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: ElevatedButton(
                          onPressed: () async {},
                          child: const Text('Click'),
                        ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [Text('Type something!')],
                  );
                }

              // TODO: Handle this case.

              default:
                return SizedBox();
            }

            // return Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: children_,
            //   ),
            // );
          })),
    );
  }

  bool isNumber(String requestId) {
    try {
      int result = int.parse(requestId);
      return true;
    } catch (e) {
      return false;
    }
  }
}

Future<String> makeNetworkCall(String? requestId) async {
  print('Api in hits\n');
  requestId ??= '1';
  print('requestId executed $requestId');

  await Future.delayed(Duration(seconds: 1));

  Uri uri = Uri.https(URL, '/todos/$requestId');

  http.Response response = await http.get(uri);
  debugPrint(response.body);

  if (response.body.isEmpty) {
    print('Its empty\n');
  } else
    print('not empty\n');
  requestStatusCode = response.statusCode;
  return response.body;
}
