import 'package:flutter/material.dart';
import 'package:unsplash_clone/views/home_view.dart';

void main() {
  runApp(UnsplashApp());
}

class UnsplashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
