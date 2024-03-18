import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';

Widget favorites(BuildContext context, HomeController controller) {
  return Column(
    children: [
      SizedBox(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            AppStrings.FAVORITES,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    controller.showFavList.value = false;
                  },
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
        child: Obx(
          () => controller.favRefresh.value
              ? const SizedBox()
              : controller.favCityList == null
                  ? const SizedBox()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      itemCount: controller.favCityList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.city = controller.favCityList![index];
                            Get.back();
                            controller.checkCityValue();
                          },
                          child: Card(
                            elevation: 2,
                            color: Colors.transparent,
                            child: Container(
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          controller.favCityList![index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.removeFavCity(index);
                                    },
                                    child: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    ],
  );
}
