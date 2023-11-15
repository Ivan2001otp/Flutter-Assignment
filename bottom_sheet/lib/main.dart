import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  return runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Bottom sheet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      home: BottomSheet(),
    );
  }
}

class BottomSheet extends StatefulWidget {
  State<BottomSheet> createState() => _BottomSheetWidgetClass();
}

class _BottomSheetWidgetClass extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Sheet Flutter !'),
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        child: Center(
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.purpleAccent),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    isDismissible: true,
                    enableDrag: false,
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Container(
                          // mainAxisSize: MainAxisSize.min,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  elevation: 8,
                                  shadowColor:
                                      Color.fromARGB(90, 158, 158, 158),
                                  child: ListTile(
                                    textColor: Colors.black,
                                    title: Text('God of War - Ragnarok'),
                                    subtitle: Text('Santa Monica Studios'),
                                  )),
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  elevation: 8,
                                  shadowColor:
                                      Color.fromARGB(90, 158, 158, 158),
                                  child: ListTile(
                                    textColor: Colors.black,
                                    title: Text('Red dead Redemption'),
                                    subtitle: Text('Rock Star games Studios'),
                                  )),
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  elevation: 8,
                                  shadowColor:
                                      Color.fromARGB(90, 158, 158, 158),
                                  child: ListTile(
                                    textColor: Colors.black,
                                    title: Text('Mumbai Gullies'),
                                    subtitle: Text('GameEon Studios'),
                                  )),
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  elevation: 8,
                                  shadowColor:
                                      Color.fromARGB(90, 158, 158, 158),
                                  child: ListTile(
                                    textColor: Colors.black,
                                    title: Text('Life is Strange'),
                                    subtitle: Text('Anon Studios'),
                                  ))
                            ],
                          ),

                          /*
                            ListTile(
                              textColor: Colors.white,
                              title: Text('God of War - Ragnarok'),
                              subtitle: Text('Santa Monica Studios'),
                            ),
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Ghost of Tsushima'),
                              subtitle: Text('Sucker Punch Studios'),
                            ),
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Red dead Redemption'),
                              subtitle: Text('Rockstar Games'),
                            ),
                            ListTile(
                              textColor: Colors.white,
                              title: Text('God of War - Ragnarok'),
                              subtitle: Text('Santa Monica Studios'),
                            ),
                            ListTile(
                              textColor: Colors.white,
                              title: Text('Asassins Creed Mirage'),
                              subtitle: Text('Ubisoft Games'),
                            ),
                            */
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'bottom sheet',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
      ),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
    
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
