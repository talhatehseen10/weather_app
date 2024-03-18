import 'package:get_storage/get_storage.dart';
import 'package:weather_app/views/home_screen/model/current_weather_data/city.dart';

class Preferences {
  final storage = GetStorage();

  void setFavCity(List<String> cities) => storage.write("favorites", cities);
  getFavCity() => storage.read("favorites");

  void setCity(String city) => storage.write("city", city);
  getCity() => storage.read("city");
}
