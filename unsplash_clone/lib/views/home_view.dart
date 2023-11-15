import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:unsplash_clone/controller/app_controller.dart';
import 'package:unsplash_clone/model/photo_model.dart';
import 'package:unsplash_clone/service/dio_service.dart';
import 'package:unsplash_clone/views/detail_view.dart';
import 'package:unsplash_clone/widget/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  final AppController _appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            //appbar
            CustomAppBar(),

            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: _BuildTabBar(),
              ),
            ),
            Expanded(
                flex: 7,
                child: Obx(() => (this._appController.isLoading.value == true)
                    ? Center(
                        child: LoadingAnimationWidget.flickr(
                            leftDotColor: Colors.red,
                            rightDotColor: Colors.green,
                            size: 30),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                        child: GridView.custom(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: SliverQuiltedGridDelegate(
                                crossAxisCount: 4,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                repeatPattern:
                                    QuiltedGridRepeatPattern.inverted,
                                pattern: const [
                                  QuiltedGridTile(2, 2),
                                  QuiltedGridTile(1, 1),
                                  QuiltedGridTile(1, 1),
                                  QuiltedGridTile(1, 2),
                                ]),
                            childrenDelegate: SliverChildBuilderDelegate(
                              childCount: _appController.unsplashPhotos.length,
                              (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          DetailsView(index: index),
                                    ));
                                  },
                                  child: Hero(
                                    tag: _appController
                                        .unsplashPhotos[index].id!,
                                    child: CachedNetworkImage(
                                      imageUrl: _appController
                                          .unsplashPhotos[index]
                                          .urls!['small']!,
                                      placeholder: (context, url) =>
                                          LoadingAnimationWidget.flickr(
                                              leftDotColor: Colors.indigo,
                                              rightDotColor: Colors.orange,
                                              size: 20),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                            decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ));
                                      },
                                    ),
                                  ),
                                );
                              },
                            )))))
          ],
        ),
      ),
    );
  }

  Widget _BuildTabBar() {
    List<String> choice = ['latest', 'oldest', 'popular', 'views'];

    return ListView.builder(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        itemCount: choice.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              this._appController.filterOrderBy(choice[index], index);
            },
            child: AnimatedContainer(
              width: 108,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      index == this._appController.selectedIndex.value
                          ? 20
                          : 12),
                  color: index == this._appController.selectedIndex.value
                      ? Color.fromARGB(219, 216, 17, 97)
                      : Colors.grey[200]),
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: Text(
                  choice[index],
                  style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: index == this._appController.selectedIndex.value
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          );
        });
  }
}
