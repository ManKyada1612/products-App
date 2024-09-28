import 'dart:convert';

import 'package:assignment/appsting.dart';
import 'package:assignment/model/cart_model.dart';
import 'package:assignment/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProductDetailStr extends GetxController {
  Rx<Products> productdata = Products().obs;

  RxBool isLoading = false.obs;
  Products productsDataFromJson(String str) =>
      Products.fromJson(json.decode(str));
  TextEditingController userStr = TextEditingController();
  TextEditingController passwordStr = TextEditingController();
  Carts cartsFromJson(String str) => Carts.fromJson(json.decode(str));
  Future login(int id, int count, Products products) async {
    print("abc");
    isLoading.value = true;
    var url = Uri.parse(
      loginutl,
    );
    final http.Response response = await http.post(url, body: {
      "username": userStr.text.trim(),
      "password": passwordStr.text.trim()
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("object");
      addcart(id: id, count: count, products: products);
      isLoading.value = false;

      final setdata = GetStorage();
      setdata.write('user', 'login');
      print(setdata.read("user"));
    } else {
      print("object${response.body}  1");
      Get.snackbar("", "Please eanter valid User name and Passwoed");
      final setdata = GetStorage();

      isLoading.value = false;
    }
  }

  Future editCart(
      {required int id,
      required String productId,
      required int count,
      required Products products}) async {
    print("abc");
    isLoading.value = true;
    var url = Uri.parse(
      addcartsurl + "/${id.toString()}",
    );
    final http.Response response =
        await http.put(url, body: json.encode({"productId": 1, "quantity": 2}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;
      Carts data = cartsFromJson(response.body);
      products.carts = data;
      products.count = count;
      print(products.count);
    } else {
      print(response.body);
      isLoading.value = false;
    }
  }

  Future deletCart(
      {required int id,
      required String productId,
      required int count,
      required Products products}) async {
    print("abc");
    isLoading.value = true;
    var url = Uri.parse(
      addcartsurl + "/${id.toString()}/remove",
    );
    final http.Response response = await http.delete(
      url,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;
    } else {
      print(response.body);
      isLoading.value = false;
    }
  }

  Future addcart(
      {required int id, required int count, required Products products}) async {
    print("abc");
    isLoading.value = true;
    var url = Uri.parse(
      addcartsurl,
    );
    final http.Response response = await http.post(url,
        body: json.encode({
          "userId": 2,
          "products": [
            {"productId": id, "quantity": count}
          ]
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;
      Carts data = cartsFromJson(response.body);
      products.carts = data;
      products.count = count;
      print(products.count);
    } else {
      print(response.body);
      isLoading.value = false;
    }
  }

  Future getProduct(id) async {
    isLoading.value = true;
    productdata.value = Products();
    // ignore: unused_local_variable
    var url = Uri.parse(
      productsurl + "/$id",
    );
    final http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;
      Products data = productsDataFromJson(response.body);
      productdata.value = data;
    } else {
      isLoading.value = false;
    }
  }
}
