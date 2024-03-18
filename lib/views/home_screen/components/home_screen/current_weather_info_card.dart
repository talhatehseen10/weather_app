import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';

Widget currentWeatherInfoCard(BuildContext context, HomeController controller) {
  return Obx(() => controller.isLoading.value
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : controller.currentWeatherErrorMsg != ""
          ? Center(
              child: Text(
                controller.currentWeatherErrorMsg,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.transparent,
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.only(top: 15, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                '${controller.currentWeatherData!.name}'
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.3,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${controller.currentWeatherData!.weather![0].description}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                              ),
                              Text(
                                'feels like ${(controller.currentWeatherData!.main!.feelsLike! - 273.15).round().toString()}\u2103',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      '${(controller.currentWeatherData!.main!.temp! - 273.15).round().toString()}\u2103',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: Colors.white,
                                          )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(
                                        AppAssets.getPNGIcon(controller
                                            .currentWeatherData!
                                            .weather![0]
                                            .icon!),
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'min: ${(controller.currentWeatherData!.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(controller.currentWeatherData!.main!.tempMax! - 273.15).round().toString()}\u2103',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'wind ${controller.currentWeatherData!.wind!.speed} m/s',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
}
