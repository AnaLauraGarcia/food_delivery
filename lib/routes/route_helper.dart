
// Este código se utilizaría en la configuración de rutas de tu aplicación, 
// normalmente dentro del GetMaterialApp en el archivo principal (main.dart).

import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/recommened_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import '../pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/admin/admin_page.dart';


class RouteHelper{
  static const String splashPage ="/splash-page";
  static const String adminPage = '/admin';
  static const String initial = "/";
  static const String signInPage ="/sign-in-page";
  static const String signUpPage ="/sign-up-page";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage ="/cart-page";
  static const String accountPage ="/account-page";

  static String getSplashPage()=>'$splashPage';
  
  static String getSignInPage()=>'$signInPage';
  static String getSignUpInPage()=>'$signUpPage';
  static String getInitial()=>'$initial';
  static String getAccountPage()=>'$accountPage';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';

  static List<GetPage> routes=[

    GetPage(name: splashPage, page: ()=>SplashScreen()),

    GetPage(name: adminPage, page: () => AdminPage()),

    // Mapea la ruta inicial ("/") a MainFoodPage.
    GetPage(name: initial, page: ()=>HomePage()),

    GetPage(name: signUpPage, page: ()=>SignUpPage()),

    GetPage(name: signInPage, page: ()=>SignInPage()),

    GetPage(name: signInPage, page: ()=>AccountPage()),
    

    

    // popularFood: Mapea la ruta de comida popular ("/popular-food") a PopularFoodDetail, 
    // extrayendo el pageId de los parámetros de la ruta y pasándolo al constructor de PopularFoodDetail.
    GetPage(name:popularFood, page:(){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters['page'];
      return PopularFoodDetail(pageId:int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn
    ),

    // recommendedFood: Mapea la ruta de comida recomendada ("/recommended-food") 
    // a RecommendedFoodDetail.

    GetPage(name:recommendedFood, page:(){   
      var pageId=Get.parameters['pageId'];  
      var page=Get.parameters['page'];
      return RecommendedFoodDetail(pageId:int.parse(pageId!), page:page!);
    },
    // Se especifica una transición de desvanecimiento (Transition.fadeIn) para las páginas.
      transition: Transition.fadeIn 
    ),
    
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn
    ),

    // GetPage(name:signInPage, page:(){
    //   var pageId=Get.parameters['user_id'];
    //   var page=Get.parameters['page'];
    //   return AccountPage(user_id:int.parse(pageId!), page:page!);
    // },
    //   transition: Transition.fadeIn
    // ),

  ];
}