import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

// La clase PopularProductController sirve como un controlador para manejar la lógica 
// de los productos populares en el carrito.
// Utiliza el paquete GetX para manejar el estado de la aplicación y se comunica con el repositorio de productos populares para obtener datos. 

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList=[];
  List<ProductModel> get popularProductList => _popularProductList; 
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity=> _quantity;
  int _inCartItems = 0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularProductList() async { // Este método obtiene la lista de productos populares desde el repositorio y actualiza el estado interno.
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      print("got products recommended");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      // print(_popularProductList);
      update();
    }else{
      print("could not get products recommended");
    }
  }

  // Funcion que se encarga de aumentar o disminuir los productos del carrito
  void setQuantity(bool isIncrement){
    if(isIncrement){
      print("increment"+_quantity.toString());
      _quantity =checkQuantity(_quantity+1);
      print("number of items"+_quantity.toString());
    }else{
      print("decrement "+_quantity.toString());
      _quantity =checkQuantity(_quantity-1);
    }

    // Funcion pora actualizar el contador al apretar. 
    update();
  }

  // Contador de la cantidad de productos. Este método verifica y asegura que la cantidad de productos en el carrito 
  // no sea menor que cero ni mayor que 20, mostrando notificaciones si se exceden estos límites.
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item count","You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }

      return 0;
    }else if(_inCartItems+quantity>20){
      Get.snackbar("Item count","You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }


// Inicializa el controlador con un producto específico y el controlador del carrito, verificando si el producto ya está en el carrito.
  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist = _cart.existInCart(product);
    print("exist or not"+exist.toString());
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
    print("the quantity in the cart is "+_inCartItems.toString());
  }


// Inicializa el controlador con un producto específico y el controlador del carrito, verificando si el producto ya está en el carrito.
  void addItem(ProductModel product){

      _cart.addItem(product, _quantity);
      
      _quantity=0;
      _inCartItems=_cart.getQuantity(product);
      
      _cart.items.forEach((key, value){
        print("The id is "+value.id.toString()+" The quantity is "+value.quantity.toString());
      });

    update();   
  }



// Estas propiedades devuelven el total de ítems en el carrito y la lista de ítems en el carrito.

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}