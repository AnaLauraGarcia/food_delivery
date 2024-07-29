import 'package:food_delivery/bbhh/preferences_service.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance(); // preferencias compartidas

  // Registra SharedPreferences primero
  Get.lazyPut(() => sharedPreferences);

  // Registra PreferencesService
  Get.lazyPut(() => PreferencesService());

  // Registra los repositorios
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => PopularProductRepo());
  Get.lazyPut(() => RecommendedProductRepo());

  // Registra el controlador CartController con el userId
  final userId = await _getUserId(sharedPreferences);
  
  Get.lazyPut(() => CartController(
    cartRepo: Get.find(),
    userId: userId, // Pasa el userId aquí
  ));
  
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
}

Future<int> _getUserId(SharedPreferences sharedPreferences) async {
  // Simulación de la obtención del userId desde SharedPreferences
  return sharedPreferences.getInt('userId') ?? 1; // Devuelve 1 si no hay userId almacenado
}
