import 'package:food_delivery/models/products_model.dart';

class CartModel {
  int? userId; 
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel({
    this.userId, 
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'quantity': quantity,
      'isExist': isExist,
      'time': time,
      'product': product!.toJson(),
    };
  }


  CartModel copyWith({
    int? userId,
    int? id,
    String? name,
    int? price,
    String? img,
    int? quantity,
    bool? isExist,
    String? time,
    ProductModel? product,
  }) {
    return CartModel(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      img: img ?? this.img,
      quantity: quantity ?? this.quantity,
      isExist: isExist ?? this.isExist,
      time: time ?? this.time,
      product: product ?? this.product,
    );
  }
}

