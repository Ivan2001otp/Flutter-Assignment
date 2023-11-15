import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: const Center(
                child: Text("Home Hello Page"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  print('Clicked About!');
                  GoRouter.of(context).pushNamed('About');
                },
                child: Text('About us page'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  print('Clicked Contact US!');
                  GoRouter.of(context).pushNamed('ContactUs');
                },
                child: Text('Contact us page'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  print('Clicked Profile!');
                  GoRouter.of(context).pushNamed('Profile');
                },
                child: Text('Profile page'),
              ),
            )
          ],
        ));
  }
}
