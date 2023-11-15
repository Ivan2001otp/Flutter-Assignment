import 'package:dio/dio.dart';

const String API_URL = 'https://api.punkapi.com/v2/beers?';

//page=2&per_page=80
class DioService {
  //dio instance

  static Future<dynamic> fetchAllBreweriesWithPageParameters(
      int page, int beers_per_page) async {
    final num page = 1;
    final num beers_per_page = 10;
    // final String first_endpoint =

    Dio dioInstance = Dio(BaseOptions(
        baseUrl: 'https://api.punkapi.com/v2/beers?',
        responseType: ResponseType.json));

    print('api called');

    Response response = await dioInstance
        .get('page=$page&per_page=$beers_per_page',
            options: Options(method: 'GET'))
        .then((responselist) {
      return responselist;
    });

    print(response);

    return response.data;
  }
}
