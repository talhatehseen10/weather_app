import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';
import 'package:weather_app/views/home_screen/model/current_weather_data/city.dart';
import 'package:weather_app/widget/custom_text_field.dart';

class SearchCity extends GetView<HomeController> {
  const SearchCity({super.key});
  static const String routeName = "/search_city";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.getJPEGImage("01n"),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                  AppStrings.SEARCH_CITY,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                prefix: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                fillColor: Colors.transparent,
                hintText: AppStrings.SEARCH,
                onChanged: (val) {
                  controller.searchCityData(val);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const SizedBox()
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        itemCount: controller.filteredCity!.length,
                        itemBuilder: (context, index) {
                          City data = controller.filteredCity![index];
                          return GestureDetector(
                            onTap: () {
                              controller.selectCity(data.name!);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "${data.name}, ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${data.country}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.white,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
