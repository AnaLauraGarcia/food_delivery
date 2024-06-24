
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

// Only for storage and sharePreferences // Solo para almacenamiento y pref.comp.
  List<CartModel> storageItems=[];


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
          isExist: true,
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
            isExist: true,
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
    cartRepo.addToCartList(getItems); // 02:08:49
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

  // Lista de comida que devuelve una lista de objetos tipo CartModel --> Lo que vemos del carrito
  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }


  //Logica para que los productos se multipliquen con la cantidad en el carrito
  int get totalAmount{
    var total=0;
    _items.forEach((key, value){
      total += value.quantity!*value.price!;
    });
    return total;

  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel>items){
    storageItems=items;
    //print("Length of cart items "+storageItems.length.toString());

    for(int i=0; i<storageItems.length;i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();

  }

  void clear(){
    _items={};
    update();
  }
}