import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/Projects/Pages/About.dart';
import 'package:my_first_app/Projects/Pages/ContactUs.dart';
import 'package:my_first_app/Projects/Pages/Home.dart';
import 'package:my_first_app/Projects/Pages/Profile.dart';
import 'package:my_first_app/Projects/Pages/ErrorPage.dart';

class MyAppRouter {
  GoRouter goRouter = GoRouter(
      routes: [
        GoRoute(
            name: "home",
            path: "/",
            pageBuilder: (context, state) {
              return MaterialPage(child: Home());
            }),
        GoRoute(
            name: "About",
            path: "/About",
            pageBuilder: (context, state) {
              return MaterialPage(child: About());
            }),
        GoRoute(
            name: "ContactUS",
            path: "/ContactUS",
            pageBuilder: (context, state) {
              return MaterialPage(child: ContactUs());
            }),
        GoRoute(
            name: "Profile",
            path: "/Profile",
            pageBuilder: (context, state) {
              return MaterialPage(child: Profile());
            })
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(child: ErrorPage());
      });
}
