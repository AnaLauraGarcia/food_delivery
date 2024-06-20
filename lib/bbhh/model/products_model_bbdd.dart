class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  // Método para convertir el modelo a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stars': stars,
      'img': img,
      'location': location,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Método para crear una instancia del modelo desde un Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      stars: map['stars'],
      img: map['img'],
      location: map['location'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}