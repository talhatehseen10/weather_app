import 'package:get/get.dart';
import 'package:weather_app/views/home_screen/Binding/HomeBinding.dart';
import 'package:weather_app/views/home_screen/views/favorites.dart';
import 'package:weather_app/views/home_screen/views/home_screen.dart';
import 'package:weather_app/views/home_screen/views/search_city.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.HOME_SCREEN,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: AppRoutes.SEARCH_CITY,
        page: () => const SearchCity(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.FAVORITES,
        page: () => const Favorites(),
        transition: Transition.cupertino)
  ];
}
