import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/bbhh/preferences_service.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  final int userId;
  final PreferencesService preferencesService = PreferencesService(); // Usa PreferencesService

  CartController({required this.cartRepo, required this.userId});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          userId: userId,
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            userId: userId,
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add an item in the cart!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    return _items.containsKey(product.id);
  }

  int getQuantity(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return _items[product.id]!.quantity!;
    }
    return 0;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) => e.value).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void updateCartHistory() {
  update(); // Esto actualizará la vista si estás usando GetX
}

  void clear() {
    _items = {};
    update();
  }

  void clearCart() {
    cartRepo.removeCart();
    _items = {}; // Limpia el estado local del carrito
    update();
  }

  Future<void> clearCartByTime(String time) async {
    try {
      List<String> cartHistoryList = await preferencesService.getCartHistoryList();
      List<CartModel> decodedCartHistoryList = cartHistoryList
          .map((jsonStr) => CartModel.fromJson(jsonDecode(jsonStr)))
          .toList();

      decodedCartHistoryList.removeWhere((item) => item.time == time);

      List<String> updatedCartHistory = decodedCartHistoryList
          .map((item) => jsonEncode(item.toJson()))
          .toList();
      await preferencesService.setCartHistoryList(updatedCartHistory);
      print("Cart History List Before: $cartHistoryList");
      print("Cart History List After: $updatedCartHistory");

      update();
    } catch (e) {
      print("Error al guardar en SharedPreferences: $e");
    }
  }

  void removeAllCarts() {
    cartRepo.removeCart();
    update(); // Actualiza la vista
  }




  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  List<CartModel> getCartHistoryListByUserId(int userId) {
    List<CartModel> allHistory = cartRepo.getCartHistoryList();
    return allHistory.where((cart) => cart.userId == userId).toList(); // Filtra por userId
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
  }
}
