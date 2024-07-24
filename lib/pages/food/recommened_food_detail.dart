// BODY DE LOS PRODUCTOS RECOMENDADOS


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Color(0xFFFFFDF6),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Page: $page'); // Imprime el valor de page
                    String route;
                    if (page == "cartpage") {
                      route = RouteHelper.getCartPage();
                    } else {
                      route = RouteHelper.getInitial();
                    }
                    print('Navigating to: $route');
                    Get.toNamed(route);
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1) Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined,),
                        controller.totalItems >= 1 ?
                        Positioned(
                          right: 0, top: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,
                          ),
                        ) :
                        Container(),
                        controller.totalItems >= 1 ?
                        Positioned(
                          right: 3, top: 3,
                          child: BigText(
                            text: controller.totalItems.toString(),
                            size: 12,
                            color: Colors.white,
                          ),
                        ) :
                        Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(child: BigText(size: Dimensions.font26, text: product.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFDF6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/image/${product.img}',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: product.description!),
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20 * 2.5, vertical: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.remove,
                    ),
                  ),
                  BigText(
                    text: "\$ ${product.price!} X ${controller.inCartItems} ",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.add,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.symmetric(vertical: Dimensions.height30, horizontal: Dimensions.width20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackaroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Color.fromARGB(216, 113, 64, 49),
                      border: Border.all(
                        color: Color(0xFFFF714031),// Color del borde
                        width: 1.0, // Ancho del borde (opcional)
                      ),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.width20),
                      child: BigText(text: "\$ ${product.price!} | Add to cart", color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

