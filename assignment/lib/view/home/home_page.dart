import 'package:assignment/model/product_model.dart';
import 'package:assignment/view/cartdata/cart_data.dart';
import 'package:assignment/view/home/controller/homestr.dart';
import 'package:assignment/view/product_detail/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScreenstr _homeScreenstr = Get.put(HomeScreenstr());
  @override
  void initState() {
    _homeScreenstr.getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => Cartdata()));
          //     },
          //     icon: Icon(Icons.add_shopping_cart_rounded))
        ],
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Obx(() {
      return _homeScreenstr.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _homeScreenstr.products.isEmpty
              ? Center(
                  child: Text("No Data Fount!"),
                )
              : Column(
                  children: [
                    DropdownButton<String>(
                      items: _homeScreenstr.categorie.value
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        _homeScreenstr.onSelectCatagory(value!);
                      },
                      value: _homeScreenstr.selectCatagory.value,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _homeScreenstr.filerproducts.length,
                          itemBuilder: (context, index) {
                            Products item = _homeScreenstr.filerproducts[index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contrxt) =>
                                              ProductDetailScreen(
                                                products: item,
                                              )));
                                },
                                title: Text(item.title!),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Price : ${item.price}"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Rate ⭐ : ${item.rating!.rate}")
                                      ],
                                    ).paddingOnly(bottom: 5),
                                  ],
                                ),
                                leading: SizedBox(
                                    height: 80,
                                    width: 50,
                                    child: Image(
                                        image: NetworkImage(
                                      item.image!,
                                    ))),
                              ),
                            );
                          }),
                    ),
                  ],
                );
    });
  }
}
