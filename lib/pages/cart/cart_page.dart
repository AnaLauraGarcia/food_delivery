import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

// 11:18

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Boton del carrito para volver atrás
                AppIcon(icon:Icons.arrow_back_ios,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize:Dimensions.iconSize24),
                SizedBox(width: Dimensions.width20*5,),
                // Boton del carrito para volver a la home
                GestureDetector(
                  onTap:(){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon:Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize:Dimensions.iconSize24),
                ),
                // Boton del carrito de compras
                GestureDetector(
                  onTap: (){
                    Get.to(()=>CartPage());
                  },
                  child: AppIcon(icon:Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize:Dimensions.iconSize24),
                )
              ]

            )
          ),
          Positioned(
            top: Dimensions.height20*5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              //color: Colors.red,
              child: MediaQuery.removePadding(
                context:context,
                removeTop:true,
                child: GetBuilder<CartController>(builder:(cartController){
                  var _cartList = cartController.getItems;
                  return ListView.builder(
                    itemCount: _cartList.length,
                    itemBuilder: (_, index){
                      return Container(
                        width: double.maxFinite,
                        height: Dimensions.height20*5,
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.height20*5,
                              height: Dimensions.height20*5,
                              margin: EdgeInsets.only(bottom: Dimensions.height10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                  )
                                ),
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white
                              ),
                            ),
                            SizedBox(width: Dimensions.width10,),
                            Expanded(child: Container(
                              height: Dimensions.height20*5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                  SmallText(text:"Spicy"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(text: cartController.getItems[index].price.toString(), color: Colors.redAccent,),
                                      Container(
                                        padding: EdgeInsets.only(top:Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width20, right: Dimensions.width10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white,
                                        ),
                                      
                                        child: Row(
                                          children: [ //Contador del carrito
                                            GestureDetector(
                                              onTap: (){
                                                cartController.addItem(_cartList[index].product!, -1);                   
                                              },
                                              child: Icon(Icons.remove, color: AppColors.signColor,)) ,// Icon -
                                            SizedBox(width: Dimensions.width10/2,),
                                            // Se coloca la cantidad exacta de cada producto en el contador
                                            BigText(text: _cartList[index].quantity.toString()), //popularProduct.inCartItems.toString()),
                                            SizedBox(width: Dimensions.width10/2,),
                                            GestureDetector(
                                              onTap: (){
                                                cartController.addItem(_cartList[index].product!, 1);                   
                                              },
                                              child: Icon(Icons.add, color: AppColors.signColor,)) // Icon +
                                          ]
                                            
                                        ),
                                      ),
                                  ],)
                                ],
                              ),
                            ),)
                          ]
                        )
                      );
                  });
                }),
              )
          ))
        ],
      ),

    );
  }
}