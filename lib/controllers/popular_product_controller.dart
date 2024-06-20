import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart'; // Asegúrate de importar tu repositorio

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList; 

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    try {
      // Carga el JSON desde assets
      String jsonString = await rootBundle.loadString('assets/json/products_popular_model.json');
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      
      // Decodifica el JSON
      List<dynamic> jsonList = jsonMap['products'];

      
      // Mapea los datos JSON a objetos ProductModel
      _popularProductList = jsonList.map((json) => ProductModel.fromJson(json)).toList();
      
      // Indica que la carga ha sido exitosa
      _isLoaded = true;
      update(); // Actualiza la UI
    } catch (e) {
      // Maneja los errores si ocurre alguno durante la carga
      print('Error cargando productos: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Cuando se inicializa el controlador, carga los productos populares
    getPopularProductList();
  }

  // Función para aumentar o disminuir la cantidad de productos en el carrito
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  // Verifica la cantidad de productos en el carrito
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  // Inicializa el producto en el controlador
  void initProduct(ProductModel product, CartController cart) {
    _cart = cart;
    var exist = _cart.existInCart(product);
    _inCartItems = exist ? _cart.getQuantity(product) : 0;
  }

  // Agrega un producto al carrito
  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  // Obtiene el número total de ítems en el carrito
  int get totalItems => _cart.totalItems;

  // Obtiene la lista de ítems en el carrito
  List<CartModel> get getItems => _cart.getItems;
}