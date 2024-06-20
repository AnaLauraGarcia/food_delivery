
// Este código se utilizaría en la configuración de rutas de tu aplicación, 
// normalmente dentro del GetMaterialApp en el archivo principal (main.dart).

import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/recommened_food_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:get/get.dart';
import '../pages/food/popular_food_detail.dart';

class RouteHelper{
  static const String initial = "/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage ="/cart-page";

  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId)=>'$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId)=>'$recommendedFood?pageId=$pageId';
  static String getCartPage()=>'$cartPage';

  static List<GetPage> routes=[
    
    // Mapea la ruta inicial ("/") a MainFoodPage.
    GetPage(name: initial, page: ()=>MainFoodPage()),
    

    // popularFood: Mapea la ruta de comida popular ("/popular-food") a PopularFoodDetail, 
    // extrayendo el pageId de los parámetros de la ruta y pasándolo al constructor de PopularFoodDetail.
    GetPage(name:popularFood, page:(){
      var pageId=Get.parameters['pageId'];
      return PopularFoodDetail(pageId:int.parse(pageId!));
    },
      transition: Transition.fadeIn
    ),

    // recommendedFood: Mapea la ruta de comida recomendada ("/recommended-food") 
    // a RecommendedFoodDetail.

    GetPage(name:recommendedFood, page:(){   
      var pageId=Get.parameters['pageId'];  
      return RecommendedFoodDetail(pageId:int.parse(pageId!));
    },
    // Se especifica una transición de desvanecimiento (Transition.fadeIn) para las páginas.
      transition: Transition.fadeIn 
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn
    )

  ];
}