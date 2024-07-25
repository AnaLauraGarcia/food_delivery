import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  final int userId;

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
        Get.snackbar("Item count", "You should at least add an item in the cart!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getItems, userId);
    update();
  }

  bool existInCart(ProductModel product) {
    return _items.containsKey(product.id);
  }

  int getQuantity(ProductModel product) {
    return _items[product.id]?.quantity ?? 0;
  }

  int get totalItems {
    return _items.values.fold(0, (total, item) => total + item.quantity!);
  }

  List<CartModel> get getItems {
    return _items.values.toList();
  }

  int get totalAmount {
    return _items.values.fold(0, (total, item) => total + item.quantity! * item.price!);
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList(userId);
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    _items.clear();
    for (var item in storageItems) {
      _items[item.product!.id!] = item;
    }
  }

  void addToHistory() {
  cartRepo.addToCartList(getItems, userId); // Asegúrate de pasar el carrito actual
  clear();
}

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList(userId);
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = setItems;
  }
}
