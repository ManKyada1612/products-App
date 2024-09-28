import 'dart:convert';

import 'package:assignment/appsting.dart';
import 'package:assignment/model/cart_model.dart';
import 'package:assignment/model/product_model.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HomeScreenstr extends GetxController {
  RxList<Products> products = <Products>[].obs;
  RxList<Products> filerproducts = <Products>[].obs;

  RxList<String> categorie = <String>["All"].obs;
  RxString selectCatagory = "All".obs;

  RxList<Carts> Cartsdata = <Carts>[].obs;
  RxBool isLoading = false.obs;
  List<String> categoriesFromJson(String str) =>
      List<String>.from(json.decode(str).map((x) => x));

  getdata() async {
    isLoading.value = true;
    await getProduct();
    await getcategorie();
    isLoading.value = false;
  }

  onSelectCatagory(String value) {
    filerproducts.clear();
    selectCatagory.value = value;
    if (value == "All") {
      filerproducts.addAll(products);
    } else {
      products.forEach((element) {
        if (element.category == value) {
          filerproducts.add(element);
        }
      });
    }
  }

  // Future getcart() async {
  //   isLoading.value = true;
  //   // ignore: unused_local_variable
  //   var url = Uri.parse(
  //     addcartsurl + "carts/user/2",
  //   );
  //   final http.Response response = await http.get(url);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     isLoading.value = false;
  //     List<Carts> data = cartsFromJson(response.body);
  //     Cartsdata.value = data;
  //     Cartsdata.forEach((element) {
  //       element.products!.forEach((elements) {
  //         products.forEach((item) {
  //           if (elements.productId == item.id) {
  //             elements.products = item;
  //           }
  //         });
  //       });
  //     });
  //   } else {
  //     isLoading.value = false;
  //   }
  // }

  Future getProduct() async {
    //  isLoading.value = true;
    products.clear();
    // ignore: unused_local_variable
    var url = Uri.parse(
      productsurl,
    );
    final http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // isLoading.value = false;
      List<Products> data = productsFromJson(response.body);
      filerproducts.value = productsFromJson(response.body);
      products.value = data;
    } else {
      //  isLoading.value = false;
    }
  }

  Future getcategorie() async {
    //  isLoading.value = true;
    categorie.clear();

    // ignore: unused_local_variable
    var url = Uri.parse(
      categoriesurl,
    );
    final http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;

      categorie.value = categoriesFromJson(response.body);
      categorie.add("All");
    } else {
      isLoading.value = false;
    }
  }
}
