import 'package:assignment/view/home/controller/homestr.dart';
import 'package:assignment/view/product_detail/controller/product_detail_str.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartdata extends StatefulWidget {
  const Cartdata({super.key});

  @override
  State<Cartdata> createState() => _CartdataState();
}

class _CartdataState extends State<Cartdata> {
  HomeScreenstr _homeScreenstr = Get.find<HomeScreenstr>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Container());
  }
}
