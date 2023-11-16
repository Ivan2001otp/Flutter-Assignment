import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static SharedPrefsManager? _instance;

  SharedPreferences? _prefs;

  SharedPrefsManager._internal() {}

  factory SharedPrefsManager() {
    if (_instance == null) {
      _instance = SharedPrefsManager._internal();
    }
    return _instance!;
  }

  Future<SharedPreferences> get prefs async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs!;
  }
}
