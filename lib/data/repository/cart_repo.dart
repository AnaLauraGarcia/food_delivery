import 'dart:convert';
import 'package:food_delivery/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  String _getCartKey(int userId) => 'cart_$userId';
  String _getCartHistoryKey(int userId) => 'cart_history_$userId';

  void addToCartList(List<CartModel> cartList, int userId) {
    var time = DateTime.now().toString();
    List<String> cart = [];

    cartList.forEach((element) {
      if (element.userId == userId) {
        element.time = time;
        cart.add(jsonEncode(element));
      }
    });

    // Guarda el carrito actual
    sharedPreferences.setStringList(_getCartKey(userId), cart);

    // Añadir al historial del carrito
    List<String> cartHistory = getCartHistoryList(userId).map((e) => jsonEncode(e)).toList();
    cart.forEach((item) {
      cartHistory.add(item);
    });
    sharedPreferences.setStringList(_getCartHistoryKey(userId), cartHistory);
  }

  List<CartModel> getCartList(int userId) {
    List<String> carts = [];
    if (sharedPreferences.containsKey(_getCartKey(userId))) {
      carts = sharedPreferences.getStringList(_getCartKey(userId))!;
    }

    List<CartModel> cartList = [];
    for (var cartString in carts) {
      var cart = CartModel.fromJson(jsonDecode(cartString));
      if (cart.userId == userId) {
        cartList.add(cart);
      }
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList(int userId) {
    List<String> cartHistory = [];
    if (sharedPreferences.containsKey(_getCartHistoryKey(userId))) {
      cartHistory = sharedPreferences.getStringList(_getCartHistoryKey(userId))!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory;
  }

  void removeCart(int userId) {
    sharedPreferences.remove(_getCartKey(userId));
  }
}
