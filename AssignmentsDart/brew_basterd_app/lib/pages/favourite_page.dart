import 'package:brew_basterd_app/model/brew_model.dart';
import 'package:brew_basterd_app/service/database_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<FavouritePage> createState() => _FavouritePageState();
}

final dbListProvider = FutureProvider<List<SavedModel>>((ref) async {
  List<SavedModel> list = await DatabaseService().getAllSavedList();
  for (int i = 0; i < list.length; i++) {
    debugPrint(list[i].image_url!);
  }
  return list;
});

class _FavouritePageState extends ConsumerState<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('Brew-App'),
      ),
      body: ref.watch(dbListProvider).when(data: (dataResponse) {
        print('favourite page data executed!');
        return ListView.builder(
            itemCount: dataResponse.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                child: Card(
                  color: const Color.fromARGB(255, 236, 218, 192),
                  elevation: 4,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            height: 110,
                            width: double.infinity,
                            child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/green_top_view.jpg',
                                image: dataResponse[index].image_url ??
                                    'assets/images/green_top_view.jpg'),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                            color: const Color.fromARGB(255, 182, 235, 183),
                            height: 110,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                dataResponse[index].name ?? 'No name in API',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            color: const Color.fromARGB(255, 244, 226, 200),
                            height: 110,
                            width: double.infinity,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete_forever,
                                  size: 25,
                                )),
                          ))
                    ],
                  ),
                ),
              );
            }));
      }, error: (_error, _stackTrace) {
        return Center(
          child: Text(
            _error.toString(),
            style: TextStyle(fontSize: 15),
          ),
        );
      }, loading: () {
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
