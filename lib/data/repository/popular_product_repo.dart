import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:food_delivery/models/products_model.dart';

import 'package:get/get.dart';


class PopularProductRepo extends GetxService {
  List<ProductModel> _products = [];

  // Método para cargar los productos desde el archivo JSON.
  Future<void> loadProductsFromJson() async {
    try {
      String jsonString = await rootBundle.loadString('assets/Json/products_model_json.json');
      List<dynamic> jsonList = jsonDecode(jsonString);
      _products = jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      print('Error cargando productos desde JSON: $e');
    }
  }

  // Método para obtener la lista de productos populares.
  Future<List<ProductModel>> getPopularProductList() async {
    if (_products.isEmpty) {
      await loadProductsFromJson();
    }
    return _products;
  }
}