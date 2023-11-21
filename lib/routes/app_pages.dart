import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rast_mobile_kanban/ui/views/description_page/description_page.dart';
import 'package:rast_mobile_kanban/ui/views/home_page/home_page.dart';
import 'package:rast_mobile_kanban/ui/views/login_page/login_page.dart';
import 'package:rast_mobile_kanban/ui/views/splash_page/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: _Paths.DESC,
      page: () => const DescriptionPage(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(seconds: 1),
      curve: Curves.decelerate,
    ),
  ];
}
