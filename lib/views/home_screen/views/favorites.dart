import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/views/home_screen/components/favorites/city.dart';
import 'package:weather_app/views/home_screen/components/favorites/favorites.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';

class Favorites extends GetView<HomeController> {
  const Favorites({super.key});
  static const String routeName = "/favorite";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.getJPEGImage("01n")),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
          () => controller.showFavList.value
              ? favorites(context, controller)
              : city(context, controller),
        ),
      ),
    );
  }
}
