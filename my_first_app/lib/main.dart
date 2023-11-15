import 'package:flutter/material.dart';
import 'package:my_first_app/Projects/Router/AppRoutConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: MyAppRouter().goRouter.routeInformationParser,
      routerDelegate: MyAppRouter().goRouter.routerDelegate,
    );
  }
}

    /*  

    final paste:
          return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "HomePage",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 58, 54, 50),
                            width: 2))),
              ),
            )
          ],
        ));




    //listview seperated : 
    ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: TextButton(
                child: Text(arrnames[index]),
                onPressed: () => {print("clicked on ${arrnames[index]}")},
              ),
            );
          },
          itemCount: arrnames.length,
          separatorBuilder: ((context, index) {
            return Divider(height: 40, thickness: 5);
          }),
        )
    

    //listview builder

    ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: TextButton(
                child: Text(arrnames[index]),
                onPressed: () => {print("clicked on ${arrnames[index]}")},
              ),
            );
          },
          itemCount: arrnames.length,
        )

    listView 
    ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Ivan', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Ram', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Ravi', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Ikishva', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Laroun', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('one', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('two', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('three', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('four', style: TextStyle(fontSize: 20)),
            ),
          ],
        )


    //margin

    Container(
          //padding: EdgeInsets.only(top: 10, left: 10),
          margin: EdgeInsets.all(30),
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 25),
          ),
        )


    //padding

    Padding(
          //padding: EdgeInsets.only(top: 10, left: 10),
          
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 25),
          ),
        )

    Center(
          child: Container(
            height: 400,
            width: 400,
            child: Image.asset('assets/Images/dum.png'),
          ),
        )

          OutlinedButton(
          child: Text('elevated Button'),
          onPressed: () {
            print('clicked ');
          },
        )

          ElevatedButton(
          child: Text('elevated Button'),
          onPressed: () {
            print('clicked ');
          },
        )


          body: TextButton(
          child: Text('Click me'),
          onPressed: () {
            print('Hello World');
          },
          style: ButtonStyle(alignment: Alignment(10.32, 100)),
        )
         */
    /*
        body: Center(
            child: Container(
                width: 300,
                height: 300,
                color: Color.fromARGB(255, 14, 146, 169),
                child: Center(
                  child: Text(
                    'This is container',
                    style: TextStyle(color: Colors.red),
                  ),
                ))));
                */
  

