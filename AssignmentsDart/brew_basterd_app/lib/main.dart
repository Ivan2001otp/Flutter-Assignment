import 'dart:ffi';

import 'package:brew_basterd_app/model/brew_model.dart';
import 'package:brew_basterd_app/pages/brew_detail.dart';
import 'package:brew_basterd_app/service/dio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(ProviderScope(
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(primarySwatch: Colors.red),
  )));
}

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

Future<List<BrewModel>> getAllBrewList(int page, int no_brews_per_page) async {
  List<dynamic> dynamicList =
      await DioService.fetchAllBreweriesWithPageParameters(
          page, no_brews_per_page);

  List<BrewModel> brewModelList = List<BrewModel>.from(
      dynamicList.map((itemModel) => BrewModel.fromJson(itemModel)));

  return brewModelList;
}

final pageNumber = StateProvider<int>((ref) => 1);
final numberOfBrewsPerPage = StateProvider((ref) => 20);

final brewResponseProvider = FutureProvider<List<BrewModel>>(
  (ref) async {
    int _pageNumber = ref.read(pageNumber);
    int _numberOfBrewsPerPage = ref.read(numberOfBrewsPerPage);

    return getAllBrewList(_pageNumber, _numberOfBrewsPerPage);
  },
);

class _HomePageState extends ConsumerState<HomePage> {
  // late List<BrewModel> responseList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brew-App'),
      ),
      body: ref.watch(brewResponseProvider).when(data: (brewList) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: brewList.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  debugPrint('clicked on ${brewList[index].id}');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BrewDetail(
                              brewName: brewList[index].name ?? 'Brew Name',
                              brewModelList: brewList[index])));
                },
                child: Card(
                  color: Color.fromARGB(255, 224, 214, 239),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  elevation: 7,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.all(4),
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: FadeInImage.assetNetwork(
                                image: brewList[index].image_url ??
                                    'assets/images/green_top_view.jpg',
                                placeholder: 'assets/images/green_top_view.jpg',
                                fit: BoxFit.cover,
                                placeholderFit: BoxFit.cover,
                                /*fit: BoxFit.cover,
                                imageUrl: brewList[index].image_url ??
                                    'assets/images/green_top_view.jpg',
                                placeholder: (context, url) =>
                                    LoadingAnimationWidget.flickr(
                                        leftDotColor: Colors.blue,
                                        rightDotColor: Colors.green,
                                        size: 25),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image_not_supported,
                                  size: 15,
                                ),*/
                              ))),
                      Expanded(
                          flex: 3,
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Name:${brewList[index].name}' ??
                                      'No value in API',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                Text(
                                  'Contributor:${brewList[index].contributed_by}' ??
                                      'No value in API',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 29, 121, 32),
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              );
            }));
      }, error: (_error, _stackTrace) {
        return Center(
          child: Text(
            '${_error.toString()}',
            style: const TextStyle(color: Colors.red),
          ),
        );
      }, loading: () {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.indigo,
        ));
      }),
    );
  }
}

/*
  List<dynamic> response =
                  await DioService.fetchAllBreweriesWithPageParameters();

              List<BrewModel> brewModelList = List<BrewModel>.from(response
                  .map((dynamic itemOfJson) => BrewModel.fromJson(itemOfJson)));

 */