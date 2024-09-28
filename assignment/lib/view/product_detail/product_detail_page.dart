import 'package:assignment/model/product_model.dart';
import 'package:assignment/view/product_detail/controller/product_detail_str.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key, required this.products});
  Products products;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailStr _productDetailStr = Get.put(ProductDetailStr());
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  RxInt count = 0.obs;
  @override
  void initState() {
    if (widget.products.carts != null) {
      // print(widget.products.carts!.products!.length);
      count.value = widget.products.count!;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildAddcart(),
      appBar: AppBar(),
      body: buildBody(),
    );
  }

  buildAddcart() {
    return Obx(() {
      return _productDetailStr.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (count > 0) {
                        count--;
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      return Text("${count}");
                    }),
                  ),
                  InkWell(
                    onTap: () {
                      count++;
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  widget.products.carts != null
                      ? InkWell(
                          onTap: count == 0
                              ? null
                              : () {
                                  final getdata = GetStorage();
                                  var value = getdata.read("user");
                                  print("abc-----> ${value}");
                                  value == null || value.isEmpty
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: Text('Login'),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Form(
                                                  key: _globalKey,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        controller:
                                                            _productDetailStr
                                                                .userStr,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Please Enter User Name";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'User name',
                                                          icon: Icon(Icons
                                                              .account_box),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            _productDetailStr
                                                                .passwordStr,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Please Enter Password";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Password',
                                                          icon:
                                                              Icon(Icons.email),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    child: Text("Submit"),
                                                    onPressed: () {
                                                      if (_globalKey
                                                          .currentState!
                                                          .validate()) {
                                                        Get.back();
                                                        _productDetailStr.login(
                                                            widget.products.id!,
                                                            count.value,
                                                            widget.products);
                                                      }
                                                    })
                                              ],
                                            );
                                          })
                                      : _productDetailStr.editCart(
                                          id: widget.products.carts!.id!,
                                          productId:
                                              widget.products.id.toString(),
                                          count: count.value,
                                          products: widget.products);
                                },
                          child: Container(
                              height: 50,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      count == 0 ? Colors.grey : Colors.black),
                              child: Text(
                                "Edit Cart",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      : InkWell(
                          onTap: count == 0
                              ? null
                              : () {
                                  final getdata = GetStorage();
                                  var value = getdata.read("user");
                                  print("abc-----> ${value}");
                                  value == null || value.isEmpty
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: Text('Login'),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Form(
                                                  key: _globalKey,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        controller:
                                                            _productDetailStr
                                                                .userStr,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Please Enter User Name";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'User name',
                                                          icon: Icon(Icons
                                                              .account_box),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            _productDetailStr
                                                                .passwordStr,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Please Enter Password";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Password',
                                                          icon:
                                                              Icon(Icons.email),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    child: Text("Submit"),
                                                    onPressed: () {
                                                      if (_globalKey
                                                          .currentState!
                                                          .validate()) {
                                                        Get.back();
                                                        _productDetailStr.login(
                                                            widget.products.id!,
                                                            count.value,
                                                            widget.products);
                                                      }
                                                    })
                                              ],
                                            );
                                          })
                                      : _productDetailStr.addcart(
                                          id: widget.products.id!,
                                          count: count.value,
                                          products: widget.products);
                                },
                          child: Container(
                              height: 50,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      count == 0 ? Colors.grey : Colors.black),
                              child: Text(
                                "Add Cart",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                ],
              ).paddingAll(10),
            );
    });
  }

  buildBody() {
    return Column(
      children: [
        Container(
          height: 200,
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image:
                  DecorationImage(image: NetworkImage(widget.products.image!))),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          widget.products.title!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text("Price : ${widget.products.price}"),
            SizedBox(
              width: 10,
            ),
            Text("Rate ⭐ : ${widget.products.rating!.rate}")
          ],
        ).paddingOnly(bottom: 5),
        Text(
          widget.products.description!,
        )
      ],
    ).paddingAll(10);
  }
}
