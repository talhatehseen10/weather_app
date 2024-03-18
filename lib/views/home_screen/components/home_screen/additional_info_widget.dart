import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';

Widget additionalInfoWidget(BuildContext context, HomeController controller) {
  return Obx(
    () => controller.isLoading.value
        ? const SizedBox()
        : controller.currentWeatherErrorMsg != ""
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Additional Information",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Card(
                          color: Colors.transparent,
                          child: Container(
                            height: 150,
                            width: 100,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Humidity",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.water_drop,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${controller.currentWeatherData!.main!.humidity}%",
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.transparent,
                          child: Container(
                            height: 150,
                            width: 100,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Pressure",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.thermostat,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Text(
                                  "${controller.currentWeatherData!.main!.pressure}",
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.transparent,
                          child: Container(
                            height: 150,
                            width: 100,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Clouds",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.cloud,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Text(
                                  "${controller.currentWeatherData!.clouds!.all}",
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
  );
}
