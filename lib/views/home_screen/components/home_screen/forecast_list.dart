import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';
import 'package:weather_app/views/home_screen/model/forecast/forecast_data.dart';

Widget forecastList(BuildContext context, HomeController controller) {
  return SizedBox(
    height: 200,
    child: Obx(
      () => controller.isForecastLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.forecastErrorMsg != ""
              ? Center(
                  child: Text(
                    controller.forecastErrorMsg,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Hourly Forecast",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shrinkWrap: true,
                          itemCount: controller.forecast!.list!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            ListElement data =
                                controller.forecast!.list![index];
                            return Card(
                              color: Colors.transparent,
                              child: Container(
                                height: 150,
                                width: 100,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      DateFormat("h:mm a").format(data.dtTxt!),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            AppAssets.getPNGIcon(
                                                data.weather![0].icon!),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${(data.main!.temp! - 273.15).round().toString()}\u2103",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
    ),
  );
}
