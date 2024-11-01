
import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  // Acá tenemos la comida guardada que eligimos.
  Map<int, CartModel> _items={};
  Map<int, CartModel> get items=>_items;


  void addItem(ProductModel product, int quantity){
    var totalQuantity=0;
    if (_items.containsKey(product.id!)){
      _items.update(product.id!, (value){
        totalQuantity = value.quantity!+quantity;
        return CartModel(
          id: value.id, 
          name: value.name, 
          price: value.price,
          img: value.img,
          quantity: value.quantity!+quantity,
          isExit: true,
          time: DateTime.now().toString(),
          product: product,
        );
        });

        if(totalQuantity<=0){
          _items.remove(product.id);
        }
      
    }else{
      if(quantity>0){
        print("length of the item is " + _items.length.toString());
        _items.putIfAbsent(product.id!, () { 
          return CartModel(
            id: product.id, 
            name: product.name, 
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExit: true,
            time: DateTime.now().toString(),
            product: product,
          );}
        );
      }else{
        Get.snackbar("Item count","You should at least add an item in the cart!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
       );
      }
    }

    // Con este update actualizamos los contadores si deseamos cambiarlos desde la pag.
    update();
    
    }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) { 
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
     });
    return totalQuantity;
  }

  // Lista de comida
  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }
}