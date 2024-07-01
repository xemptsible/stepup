import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class ReadData {
  Future<List<Brand>> loadBrandData() async {
    var data = await rootBundle.loadString("assets/files/brandList.json");
    var dataJson = jsonDecode(data);
    List<Brand> cateList =
        (dataJson['brand'] as List).map((e) => Brand.fromJson(e)).toList();
    return cateList;
  }

  Future<List<Product>> loadProductData() async {
    var data = await rootBundle.loadString("assets/files/productList.json");
    var dataJson = jsonDecode(data);
    List<Product> proList =
        (dataJson['product'] as List).map((e) => Product.fromJson(e)).toList();
    return proList;
  }

  Future<List<Product>> loadProductUseBrand(int brand) async {
    var data = await rootBundle.loadString("assets/files/productList.json");
    var dataJson = jsonDecode(data);
    List<Product> proList = (dataJson['product'] as List)
        .map((e) => Product.fromJson(e))
        .where((element) => element.brand == brand)
        .toList();
    return proList;
  }
}
