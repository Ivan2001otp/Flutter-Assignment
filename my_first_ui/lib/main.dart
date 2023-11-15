import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hey my first Ui',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(10),
                      onPressed: () {
                        print("menu clicked");
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          print("search clicked");
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  scrollDirection: Axis.horizontal,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Messages",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    const SizedBox(width: 20),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Online",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    const SizedBox(width: 20),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Calls",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    const SizedBox(width: 20),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Reels",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    const SizedBox(width: 20),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Status",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    const SizedBox(width: 20),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Container(
              height: 220,
              decoration: const BoxDecoration(
                  color: Color(0xFF27c1a9),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text('Favourites contacts',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    Image.asset('assets/images/dum.png').image,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 13, top: 5),
                              child: const Text(
                                'Ivan',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    Image.asset('assets/images/dum.png').image,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 13, top: 5),
                              child: const Text(
                                'Ivan',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    Image.asset('assets/images/dum.png').image,
                                // child: Expanded(
                                //     child:
                                //         Image.asset('assets/images/dum.png')),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 13, top: 5),
                              child: const Text(
                                'Ivan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
