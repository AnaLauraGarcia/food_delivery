import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'dart:async';  // Para usar Timer()


class SplashScreen extends StatefulWidget {
  const SplashScreen ({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

// 01:36:16

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

// Esto es para que carge toda la data antes que se muestre la página
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    _loadResources();
    super.initState();
    controller = AnimationController( // Durante cuando time
      vsync: this, 
      duration: const Duration(seconds: 2))..forward(); // 01:45:49
    
    animation = CurvedAnimation( // Que tipo de animation
      parent: controller, 
      curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDF6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale:animation,
          child: Center(child: Image.asset("assets/image/logo.png"))),
        ]
      )

    );
  }
}