import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/routes/app_pages.dart';
import 'package:weather_app/routes/app_routes.dart';

void main() async {
  await GetStorage.init();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.APP_NAME,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.HOME_SCREEN,
      getPages: AppPages.pages,
    );
  }
}
