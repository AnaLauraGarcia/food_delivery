import 'dart:convert';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    List<String> cart = []; // Inicializa la lista aquí

    cartList.forEach((element) {
      element.time = time;
      cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST) ?? [];
    }

    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    List<String> cartHistory = [];
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST) ?? [];
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartListHistory;
  }

  List<CartModel> getCartHistoryListByUserId(int userId) {
    List<CartModel> cartHistoryList = getCartHistoryList();
    return cartHistoryList.where((cart) => cart.userId == userId).toList();
  }

  void addToCartHistoryList() {
    List<String> cartHistory = [];
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST) ?? [];
    }

    List<String> cart = getCartList().map((item) => jsonEncode(item)).toList();

    cartHistory.addAll(cart);
    removeCart(); // Limpiar el carrito después de agregar al historial

    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("The length of history list is ${getCartHistoryList().length}");

    getCartHistoryList().forEach((item) {
      print("The time for the order is ${item.time}");
    });
  }

  void removeCart() {
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
