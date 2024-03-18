import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/views/home_screen/components/home_screen/additional_info_widget.dart';
import 'package:weather_app/views/home_screen/components/home_screen/current_weather_info_card.dart';
import 'package:weather_app/views/home_screen/components/home_screen/app_bar.dart';
import 'package:weather_app/views/home_screen/components/home_screen/forecast_list.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const String routeName = "/home_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: Get.height * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppAssets.getJPEGImage("01n"),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Obx(
                () => controller.noInternet.value
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.NO_INTERNET_CONNECTION,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.checkInternetConnectivity();
                              },
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            appBar(context, controller),
                            const SizedBox(
                              height: 10,
                            ),
                            currentWeatherInfoCard(context, controller),
                            const SizedBox(
                              height: 10,
                            ),
                            forecastList(context, controller),
                            const SizedBox(
                              height: 10,
                            ),
                            additionalInfoWidget(context, controller)
                          ],
                        ),
                      ),
              )),
        ],
      ),
    );
  }
}
