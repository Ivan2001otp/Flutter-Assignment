import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SnapHome(),
    debugShowCheckedModeBanner: false,
  ));
}

class SnapHome extends StatefulWidget {
  @override
  State<SnapHome> createState() => _SnapHomeState();
}

class _SnapHomeState extends State<SnapHome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: new DecorationImage(

                    /*colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.darken)
                    */

                    image: new AssetImage('assets/images/car.jpg'),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                /*Positioned(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 1.0)),
                margin: EdgeInsets.only(left: 10),
              ),
              top: 10,
            )
            */

                Positioned(
                    //refresh widget
                    right: 10,
                    bottom: 10,
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: const Color.fromARGB(78, 158, 158, 158)
                              .withOpacity(0.2),
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.refresh_outlined,
                            grade: 0,
                            color: const Color.fromARGB(158, 255, 255, 255)
                                .withOpacity(0.6),
                            size: 50,
                          ),
                        ),
                      ),
                    )),

                Positioned(
                    //profile widget
                    left: 10,
                    bottom: 10,
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: const Color.fromARGB(78, 158, 158, 158)
                              .withOpacity(0.2),
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.person_outline_rounded,
                            grade: 0,
                            color: const Color.fromARGB(158, 255, 255, 255)
                                .withOpacity(0.6),
                            size: 50,
                          ),
                        ),
                      ),
                    )),

                Positioned(
                    right: 10,
                    top: 10,
                    child: ClipOval(
                      //trims to circle
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: const Color.fromARGB(78, 158, 158, 158)
                              .withOpacity(0.2),
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.settings,
                            size: 40,
                            color: Color.fromARGB(123, 127, 122, 122),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    top: 10,
                    left: 10,
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: const Color.fromARGB(78, 158, 158, 158)
                              .withOpacity(0.2),
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.cancel_outlined,
                            grade: 0,
                            color: const Color.fromARGB(158, 255, 255, 255)
                                .withOpacity(0.6),
                            size: 50,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    right: 10,
                    top: 300,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.white, width: 5),
                      )),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent.withOpacity(0.4)),
                        width: 60,
                        height: 190,
                        child: BackdropFilter(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  child: Icon(
                                    Icons.child_care,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  radius: 30,
                                  child: Icon(
                                    Icons.voice_chat,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  child: Icon(
                                    Icons.piano_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5)),
                      ),
                    )),
                //bottom - horizontal
                Positioned(
                    bottom: 10,
                    left: 120,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                          shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.white, width: 5),
                      )),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent.withOpacity(0.4)),
                        width: 170,
                        height: 55,
                        child: BackdropFilter(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  radius: 25,
                                  child: Icon(
                                    Icons.video_camera_back_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  child: Icon(
                                    Icons.hd_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5)),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
