import 'dart:convert';
import 'package:flutter/services.dart'; // Para cargar archivos desde assets
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    try {
      // Carga el JSON desde assets
      String jsonString = await rootBundle.loadString('assets/json/recommended_products_model.json');
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      // Verifica si la clave 'products' existe y no es nula
      if (jsonMap.containsKey('products') && jsonMap['products'] != null) {
        // Decodifica el JSON
        List<dynamic> jsonList = jsonMap['products'];

        // Mapea los datos JSON a objetos ProductModel
        _recommendedProductList = jsonList.map((json) => ProductModel.fromJson(json)).toList();

        // Indica que la carga ha sido exitosa
        _isLoaded = true;
        update(); // Actualiza la UI
      } else {
        // Maneja el caso cuando la clave 'products' no existe o es nula
        print('Error: La clave "products" no existe o es nula en el JSON.');
      }
    } catch (e) {
      // Maneja los errores si ocurre alguno durante la carga
      print('Error cargando productos: $e');
    }
  }
}
