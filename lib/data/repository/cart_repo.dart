import 'dart:convert';
import 'package:food_delivery/models/cart_model.dart';
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

    cartList.forEach((element) {
      return cart.add(jsonEncode(element)); // Convierte en un objeto
    });
    sharedPreferences.setStringList("Cart-list", cart);
    print(sharedPreferences.getStringList("Cart-list"));
  }

}