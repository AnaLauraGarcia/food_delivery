// BODY DE LOS PRODUCTOS POPULARES


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';


class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    print("page is id "+pageId.toString());
    print("product name is "+product.name.toString());

    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>()); // Establece en 0 al contador de los productos cada vez que cambia de comida.

    return Scaffold(
      backgroundColor:  Color(0xFFFFFDF6),
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover, //Este es el que amplia la imagen gasta los bordes
                  image: AssetImage(                    //7:11:03
                    'assets/image/${product.img!}',
                  ),
                ),
              ),
            ),
          ),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Boton para volver para atrás.
              GestureDetector(
                onTap: (){
                  if (page=="cartpage"){
                    Get.toNamed(RouteHelper.getCartPage());
                  }else{
                    Get.toNamed(RouteHelper.getInitial());
                  }
                },
                child: 
                  AppIcon(icon: Icons.arrow_back_ios)
              ),

              // Boton del carrito
              // AppIcon(icon: Icons.shopping_cart_outlined),
              GetBuilder<PopularProductController>(builder:(controller){
                return GestureDetector(
                  onTap: (){
                    if(controller.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartPage());
                  },
                  child: Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined,),
                      controller.totalItems>=1?
                        Positioned(
                          right:0, top:0,
                          
                            child: AppIcon(icon: Icons.circle, size:20, 
                              iconColor: Colors.transparent, 
                              backgroundColor: AppColors.mainColor,),
                          
                        ):
                        Container(),
                          Get.find<PopularProductController>().totalItems>=1?
                          Positioned(
                            right:3, top:3,
                            child: BigText(text:Get.find<PopularProductController>().totalItems.toString(),
                            size:12, color: Colors.white,
                            ),
                          ):
                          Container(),
                    ],
                    ),
                );
              })
            ],
            ),
          ),
          //introduction of food
          Positioned(
            left:0,
            right: 0,
            bottom: 0,
            top:Dimensions.popularFoodImgSize-20,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20) ,
                    topLeft: Radius.circular(Dimensions.radius20) ,
                  ),
                  color: Color(0xFFFFFDF6),
                  //color: Colors.redAccent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text:product.name!),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Descripción"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!)))
                  ],
                )
            ),
          ),
          //expandable text widget
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top:Dimensions.height30,bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
          decoration: BoxDecoration(
            color: Color(0xFFFFFDF6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top:Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Color.fromARGB(216, 113, 64, 49),
                      border: Border.all(
                        color: Color(0xFFFF714031),// Color del borde
                        width: 1.0, // Ancho del borde (opcional)
                      ),
                ),
              
                child: Row(
                  children: [ //Contador de productos populares
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(false);                     
                      },
                      child: Icon(Icons.remove, color:  Color(0xFFFEF9D9D),)) ,// Icon -
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.inCartItems.toString(), color: Colors.white),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(true);                     
                      },
                      child: Icon(Icons.add, color: Color(0xFFFEF9D9D),)) // Icon +
                  ]
                    
                ),
              ),
              GestureDetector(
                onTap:(){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top:Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),                
                  
                    child: BigText(text: "\$ ${product.price!} | Agregar al carrito", color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
        );
    },),
    );
  }
}

