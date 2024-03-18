import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/preferences/preferences.dart';
import 'package:weather_app/views/home_screen/model/current_weather_data/city.dart';
import 'package:weather_app/services/api/api_constants.dart';
import 'package:weather_app/services/api/base_client.dart';
import 'package:weather_app/views/home_screen/model/current_weather_data/current_weather_data.dart';
import 'package:weather_app/views/home_screen/model/forecast/forecast_data.dart'
    as f_model;
import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;
  RxBool isLoading = true.obs;
  CurrentWeatherData? currentWeatherData;
  List<CurrentWeatherData> dataList = [];
  List<City>? cities;
  List<City>? filteredCity;
  List<String>? favCityList = [];
  f_model.ForecastData? forecast;
  RxBool isForecastLoading = true.obs;
  RxBool favRefresh = false.obs;
  RxBool showFavList = true.obs;
  RxBool noInternet = false.obs;
  String currentWeatherErrorMsg = "";
  String forecastErrorMsg = "";

  @override
  void onInit() {
    checkInternetConnectivity();
    super.onInit();
  }

  ///This function checks the city that you have searched if not by default it will search Karachi weather.
  void checkCityValue() {
    city = Preferences().getCity();
    if (city == null || city == "") {
      city = "karachi";
      getCurrentWeatherData();
      getForecast();
      readJson();
    } else {
      getCurrentWeatherData();
      getForecast();
      readJson();
    }
  }

  ///This function checks the connectivity of internet.
  void checkInternetConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      noInternet.value = true;
    } else {
      noInternet.value = false;
      checkCityValue();
    }
  }

  ///This function readJson file that contains list of cities.
  Future<void> readJson() async {
    String response = await rootBundle.loadString('assets/cities.json');
    var data = await json.decode(response);
    cities = List<City>.from(data.map((x) => City.fromJson(x)));
    filteredCity = cities;
  }

  ///This function get current weather condition from API.
  Future<void> getCurrentWeatherData() async {
    await BaseClient.safeApiCall(
      ApiConstants.GET_CURRENT_WEATHER,
      RequestType.get,
      headers: await BaseClient.generateHeaders(),
      queryParameters: {"q": city, "appid": "053f9bf2fe9716fec86a6e3279fc9fed"},
      onSuccess: (response) {
        currentWeatherData = CurrentWeatherData.fromJson(response.data);
        isLoading.value = false;
      },
      onLoading: () {
        isLoading.value = true;
      },
      onError: (e) {
        currentWeatherErrorMsg = e.response!.data["message"];
        isLoading.value = false;
      },
    );
  }

  ///This function get the forecast of current city.
  Future<void> getForecast() async {
    await BaseClient.safeApiCall(
      ApiConstants.GET_FORECAST,
      RequestType.get,
      headers: await BaseClient.generateHeaders(),
      queryParameters: {"q": city, "appid": "053f9bf2fe9716fec86a6e3279fc9fed"},
      onSuccess: (response) {
        forecast = f_model.ForecastData.fromJson(response.data);
        isForecastLoading.value = false;
      },
      onLoading: () {
        isForecastLoading.value = true;
      },
      onError: (e) {
        forecastErrorMsg = e.response!.data["message"];
        isForecastLoading.value = false;
      },
    );
  }

  ///This function add favorite city.
  void addFavCity(String city) {
    favRefresh.value = true;
    if (favCityList == null) {
      favCityList![0] = city;
    } else {
      favCityList!.add(city);
    }
    Preferences().setFavCity(favCityList!);
    Preferences().setCity(city);
    getFavCity();
    filteredCity = cities;
    favRefresh.value = false;
    showFavList.value = true;
  }

  ///This function get saved favorite cities.
  void getFavCity() {
    favRefresh.value = true;
    favCityList = Preferences().getFavCity();
    favRefresh.value = false;
  }

  ///This function remove favorite City.
  void removeFavCity(int index) {
    favCityList!.removeAt(index);
    Preferences().setFavCity(favCityList!);
    getFavCity();
  }

  ///This function filter city list by search.
  void searchCityData(String val) {
    isLoading.value = true;
    if (val.isNotEmpty) {
      filteredCity = cities!
          .where((element) =>
              element.name!.toLowerCase().contains(val.toLowerCase()) ||
              element.country!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filteredCity = cities;
    }
    isLoading.value = false;
  }

  ///This function get first select the selected city then get weather condition of selected city.
  void selectCity(String city) {
    Get.back();
    this.city = city;
    getCurrentWeatherData();
    getForecast();
    filteredCity = cities;
  }

  ///This function get current location city.
  void getCurrentCity() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium)
        .timeout(const Duration(seconds: 5));

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      city = placemarks[0].locality;
    } catch (err) {}
  }
}
