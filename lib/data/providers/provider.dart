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

  Future<Brand?> getBrandById(int id) async {
    List<Brand> brandList = await loadBrandData();
    try {
      Brand brand = brandList.firstWhere((brand) => brand.id == id);
      return brand;
    } catch (e) {
      return null; // If no brand with the given ID is found
    }
  }

  Future<List<Product>> loadProductData() async {
    var data = await rootBundle.loadString("assets/files/productList.json");
    var dataJson = jsonDecode(data);
    List<Product> proList =
        (dataJson['product'] as List).map((e) => Product.fromJson(e)).toList();
    return proList;
  }

  Future<List<Product>> loadProductBrand(String brand) async {
    var data = await rootBundle.loadString("assets/files/productList.json");
    var dataJson = jsonDecode(data);
    List<Product> proList = (dataJson['product'] as List)
        .map((e) => Product.fromJson(e))
        .where((element) => element.brand == brand)
        .toList();
    return proList;
  }

  Future<List<Product>> searchProduct(String text) async {
    var data = await rootBundle.loadString("assets/files/productList.json");
    var dataJson = jsonDecode(data);
    List<Product> proList =
        (dataJson['product'] as List).map((e) => Product.fromJson(e)).toList();

    // Lọc danh sách sản phẩm dựa trên từ khóa tìm kiếm
    List<Product> filteredList = proList.where((product) {
      return product.name!.toLowerCase().contains(text.toLowerCase());
    }).toList();

    return filteredList;
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
