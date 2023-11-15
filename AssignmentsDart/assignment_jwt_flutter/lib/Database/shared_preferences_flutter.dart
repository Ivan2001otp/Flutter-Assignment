import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceEntity {
  static getPreferenceDB() {
    WidgetsFlutterBinding.ensureInitialized();
    return SharedPreferences.getInstance();
  }
}
