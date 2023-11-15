import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:unsplash_clone/controller/app_controller.dart';

class DetailsView extends StatelessWidget {
  DetailsView({super.key, required this.index});
  final int index;

  //provides controller of type AppController
  final AppController _appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: _appController.unsplashPhotos[index].id!,
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: LoadingAnimationWidget.flickr(
                  leftDotColor: Colors.green,
                  rightDotColor: Colors.indigo,
                  size: 25),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              size: 30,
            ),
            imageUrl: _appController.unsplashPhotos[index].urls!['regular']!,
            imageBuilder: (context, imageProvider) {
              return Stack(
                children: [
                  Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      right: 0,
                      //here i will place my image
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image(image: imageProvider, fit: BoxFit.cover),
                      )),
                  Container(
                    //adding gradient
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent
                        ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                  Positioned(
                      bottom: 30,
                      left: 10,
                      child: Text(
                        'Created At : ${_appController.unsplashPhotos[index].created_at!.substring(0, 10).replaceAll("-", "/")}',
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                      bottom: 15,
                      right: 10,
                      child: Visibility(
                        visible: false,
                        child: GestureDetector(
                          onTap: () async {
                            print('download');
                          },
                          child: Icon(
                            Icons.download_rounded,
                            color: Colors.white,
                            size: 33,
                          ),
                        ),
                      ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void displayAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
        onPressed: () {
          //dismiss
        },
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.indigo),
        ));

    Widget continueButton = TextButton(
        onPressed: () {},
        child: Text(
          'Download',
          style: TextStyle(color: Colors.indigo),
        ));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Downloading Image'),
      content: Text('Do you really want to download the image ?'),
      actions: [cancelButton, continueButton],
    );

    showDialog(
        context: context,
        builder: ((context) {
          return alertDialog;
        }));
  }
}
