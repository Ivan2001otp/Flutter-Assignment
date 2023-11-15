import 'package:flutter/rendering.dart';

class BrewModel {
  BrewModel(
      {required this.id,
      required this.name,
      required this.tagline,
      required this.first_brewed,
      required this.description,
      required this.image_url,
      required this.ph,
      required this.food_pairing,
      required this.brewer_tips,
      required this.contributed_by});

  int? id;
  String? name;
  String? tagline;
  String? first_brewed;
  String? description;

  String? image_url;
  double? ph;
  List<String>? food_pairing;
  String? brewer_tips;
  String? contributed_by;

  BrewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    first_brewed = json['first_brewed'];
    description = json['description'];
    image_url = json['image_url'];
    ph = json['ph'];
    food_pairing = json['food_pairing'] == null
        ? []
        : List<String>.from(json['food_pairing']!.map((item) => item));
    brewer_tips = json['brewer_tips'];
    contributed_by = json['contributed_by'];
  }
}
