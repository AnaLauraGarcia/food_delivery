import 'dart:convert';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 02:08:49

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];
  void addToCartList(List<CartModel> cartList){
    cart=[];

/* 
    02:13:19 Convert objects to string because sharedPreferences only accepts string
*/

    // cartList.forEach((element) {
    //   return cart.add(jsonEncode(element)); // Convierte en un objeto
    // });

  // Forma Abreviada:
    cartList.forEach((element)=>cart.add(jsonEncode(element)));


    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList"+carts.toString());
    }
    
    List<CartModel> cartList=[];

    // carts.forEach((element) {

    //   // 02:26:28
    //   cartList.add(CartModel.fromJson(jsonDecode(element)));
      
    // });
    

    // Forma abreviada
    carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }
}