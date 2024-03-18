import 'package:get/instance_manager.dart';
import 'package:weather_app/views/home_screen/controller/HomeController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
