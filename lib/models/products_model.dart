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
  int? typeId;

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
    this.typeId
  });

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    typeId = json['typeId'];
  }

  Map<String, dynamic> toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "location": this.location,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
      "typeId": this.typeId,
    };
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    int? stars,
    String? img,
    String? location,
    String? createdAt,
    String? updatedAt,
    int? typeId,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stars: stars ?? this.stars,
      img: img ?? this.img,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      typeId: typeId ?? this.typeId,
    );
  }
}
