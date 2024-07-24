import 'package:flutter/material.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/recommened_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import '../pages/food/popular_food_detail.dart';
import 'package:food_delivery/bbhh/preferences_service.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String signInPage = "/sign-in-page";
  static const String signUpPage = "/sign-up-page";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String accountPage = "/account-page";

  static String getSplashPage() => '$splashPage';
  static String getSignInPage() => '$signInPage';
  static String getSignUpPage() => '$signUpPage';
  static String getInitial() => '$initial';
  static String getAccountPage() => '$accountPage';
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: signUpPage, page: () => SignUpPage()),
    GetPage(name: signInPage, page: () => SignInPage()),
    GetPage(name: accountPage, page: () => AccountPage()),

    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail(
        pageId: int.parse(pageId!),
        page: page!,
      );
    }, transition: Transition.fadeIn),

    GetPage(name: recommendedFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetail(
        pageId: int.parse(pageId!),
        page: page!,
      );
    }, transition: Transition.fadeIn),

    GetPage(name: cartPage, page: () {
      return FutureBuilder<int?>(
        future: Get.find<PreferencesService>().getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Indicador de carga mientras se obtiene el userId
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Manejo de errores
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user ID available')); // Manejo de falta de datos
          } else {
            final userId = snapshot.data!;
            final cartRepo = Get.find<CartRepo>();
            return CartPage(
              userId: userId,
              cartRepo: cartRepo,
            );
          }
        },
      );
    }, transition: Transition.fadeIn),
  ];
}
