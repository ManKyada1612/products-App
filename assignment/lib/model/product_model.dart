// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

import 'package:assignment/model/cart_model.dart';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Carts? carts;
  int? count;
  Rating? rating;

  Products({
    this.id,
    this.title,
    this.price,
    this.carts,
    this.description,
    this.category,
    this.count,
    this.image,
    this.rating,
  });

  Products copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) =>
      Products(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rating: rating ?? this.rating,
      );

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        count: 0,
        image: json["image"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating?.toJson(),
      };
}

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  Rating copyWith({
    double? rate,
    int? count,
  }) =>
      Rating(
        rate: rate ?? this.rate,
        count: count ?? this.count,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
