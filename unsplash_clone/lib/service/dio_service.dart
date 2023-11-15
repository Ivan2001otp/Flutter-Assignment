import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_clone/model/photo_model.dart';

final String API_KEY = 'sW9iTeFp3P8oehIsWne-xyMy8NtB3wRQ5JLc3_WSPqE';

class DioService {
  DioService();

  static Future<dynamic> unsplashNetworkCall(String orderyBy) async {
    debugPrint('network call function call \n');

    Dio dioInstance = Dio(BaseOptions(
        /*
        sendTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        */
        responseType: ResponseType.json,
        baseUrl:
            'https://api.unsplash.com/photos/?per_page=30&order_by=${orderyBy}'));

    debugPrint('Created the instance of dio \n');

    Response response = await dioInstance
        .get('&client_id=$API_KEY', options: Options(method: 'GET'))
        .then((result) {
      debugPrint("Result got from API\n");
      return result;
    });
    debugPrint('obtained the response from API \n');
    print(' Status code : ${response.statusCode}');
    // List<PhotoModel> photoList = List.empty(growable: true);
/*
    if (response.statusCode == 200) {
      photoList = jsonDecode(response.data) as List<PhotoModel>;
    }
    */
    debugPrint('Got the response from Unsplash \n');

    print(response.data);
    return response.data;
  }
}
