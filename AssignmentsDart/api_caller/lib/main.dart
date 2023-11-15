import 'dart:convert';

import 'package:api_caller/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' as Dio_;

void main() {
  runApp(ProviderScope(
      child: MaterialApp(
    home: HomePage(),
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  )));
}

const String API_KEY = 'c81fbc7d90dc7778e2fb0dd90f6b94d2';
const String BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
//$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric
//lat={lat}&lon={lon}&appid={API key}

/*
Future<String> initiateNetworkcall(double latitude, double longitude) async {
  final dioInstance = Dio_.Dio();

  final Dio_.Response response = await dioInstance
      .get('${BASE_URL}lat=$latitude&lon=$longitude&appid=$API_KEY');

  print('Function call - ' + response.toString());
  return response.data;
}
*/

Future<dynamic> initiateNetworkCall(String cityName) async {
  print('fetching..');

  final dio = Dio_.Dio();
  Dio_.Response response;
/*
    Dio_.Response response =
        await dio.get('${BASE_URL}lat=$lats&lon=$longs&appid=$API_KEY');
*/
  response =
      await dio.get('${BASE_URL}?q=$cityName&appid=${API_KEY}&units=metric');

  //ok status

  print('success status');

  return response.data;
  /*
      var result = await json.decode(response.data);
      print(result);
      WeatherMaster instance = WeatherMaster.fromJson(result);
      return instance;
      */
  // print('Null status');
}

final textualResponseObserver = StateProvider<String>((ref) {
  return 'No Response till now';
});

class HomePage extends ConsumerWidget {
  /*
  TextEditingController _latsController = TextEditingController();
  TextEditingController _longsController = TextEditingController();
  */
  TextEditingController citycontroller = TextEditingController();

  // FutureProvider<String>? weatherProviderTemp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      color: Colors.red,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          ref.watch(textualResponseObserver),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                controller: citycontroller,
                decoration: InputDecoration(
                    label: Text('City Name'),
                    hintText: 'Eg : Beijing , Dubai',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ElevatedButton(
                  onPressed: () async {
                    String cityName = citycontroller.text;
                    // double longitude = double.parse(_longsController.text);

                    //get parsed  json data
                    try {
                      Map<String, dynamic> result =
                          await initiateNetworkCall(cityName);
                      WeatherResult weatherResult =
                          WeatherResult.fromJson(result);
                      print(weatherResult);

                      ref.read(textualResponseObserver.notifier).state =
                          'pressure : ${weatherResult.main?.pressure}\nvisibility : ${weatherResult.visibility}\nweather : ${weatherResult.weather.first.description}\n Country : ${weatherResult.sys?.country}';
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text('Click')),
            )
          ],
        ),
      ),
    );
  }
}
/*

          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(response),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                //latitude
                child: TextField(
                  controller: _latsController,
                  decoration:
                      InputDecoration(labelText: 'Latitude', hintText: '10.99'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                //longitude
                child: TextField(
                  controller: _latsController,
                  decoration: InputDecoration(
                      labelText: 'Longitude', hintText: '44.45'),
                ),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {

                      if(!_latsController.text.isEmpty && !_longsController.text.isEmpty){
                           double doubleLats = double.parse(_latsController.text);
                           double doubleLongs = double.parse(_longsController.text);

                          //ref.refresh(latitude: doubleLats, longitude: doubleLongs)


                        }
                     

                      
                    },
                    child: Text('API-CALL')),
              )
            ],
          );
       
 */
