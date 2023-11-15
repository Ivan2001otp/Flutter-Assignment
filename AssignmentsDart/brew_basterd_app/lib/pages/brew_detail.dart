import 'dart:math';

import 'package:brew_basterd_app/model/brew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrewDetail extends StatelessWidget {
  final String brewName;
  final BrewModel brewModelList;
  //
  BrewDetail({required this.brewModelList, required this.brewName});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('$brewName'),
      ),
      backgroundColor: Colors.white,
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'id : ${brewModelList.id}',
                style: TextStyle(fontSize: 16),
              ),
              Text('name:${brewModelList.name}'),
              Text('First-Brewed:${brewModelList.first_brewed}'),
              Text('PH-value:${brewModelList.ph}'),
              Text(
                'Description : ${brewModelList.description}',
                style: TextStyle(fontSize: 15),
              ),
              Text(
                'Tagline:${brewModelList.tagline}',
                style: TextStyle(fontSize: 16),
              )
            ],
          )),
    );
  }
}
