import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';

Widget appBar(BuildContext context, HomeController controller) {
  return SizedBox(
    child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.SEARCH_CITY);
        },
        child: Container(
          width: double.infinity,
          //margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Text(
              AppStrings.SEARCH,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.FAVORITES);
            },
            child: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              controller.getCurrentCity();
            },
            child: const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    ),
  );
}
