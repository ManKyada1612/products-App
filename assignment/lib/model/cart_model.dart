// To parse this JSON data, do
//
//     final carts = cartsFromJson(jsonString);

import 'dart:convert';

Carts cartsFromJson(String str) => Carts.fromJson(json.decode(str));

String cartsToJson(Carts data) => json.encode(data.toJson());

class Carts {
  int? id;
  int? userId;
  List<Product>? products;

  Carts({
    this.id,
    this.userId,
    this.products,
  });

  Carts copyWith({
    int? id,
    int? userId,
    List<Product>? products,
  }) =>
      Carts(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        products: products ?? this.products,
      );

  factory Carts.fromJson(Map<String, dynamic> json) => Carts(
        id: json["id"],
        userId: json["userId"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  int? productId;
  int? quantity;

  Product({
    this.productId,
    this.quantity,
  });

  Product copyWith({
    int? productId,
    int? quantity,
  }) =>
      Product(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
