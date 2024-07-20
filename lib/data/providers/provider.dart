import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class ReadData {
  Future<List<Brand>> loadBrandData() async {
    ApiService apiService = ApiService();
    List<Brand> brandList = await apiService.fetchBrands();
    return brandList;
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
    ApiService apiService = ApiService();
    List<Product> proList = await apiService.fetchProducts();
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

  Future<List<Product>> searchProduct(
    String text, {
    String? brand,
    RangeValues? price,
    int? size,
  }) async {
    ApiService apiService = ApiService();
    List<Product> proList = await apiService.searchProduct(text,
        brand: brand, size: size, price: price);
    return proList;
  }

  Future<List<Product>> loadProductUseBrand(String brand) async {
    ApiService apiService = ApiService();
    List<Product> proList = await apiService.fetchProductsByBrand(brand);
    return proList;
  }

  Future<List<Product>> loadFavoritedProduct() async {
    List<Product> data = await SharePreHelper().getFavoriteItemList();
    return data;
  }
}
