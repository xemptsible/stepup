import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';
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

  Future<List<Product>> searchProduct(
    String text, {
    String? brand,
    RangeValues? price,
    int? size,
  }) async {
    var data = await rootBundle.loadString("assets/files/productList.json");
    var dataJson = jsonDecode(data);
    List<Product> proList =
        (dataJson['product'] as List).map((e) => Product.fromJson(e)).toList();

    // Lọc danh sách sản phẩm dựa trên từ khóa tìm kiếm và các tiêu chí khác
    List<Product> searchList = proList.where((product) {
      bool matchesText =
          product.name!.toLowerCase().contains(text.toLowerCase());
      bool matchesBrand =
          brand == null || brand == "Tất cả" || product.brand == brand;
      bool matchesPrice = price == null ||
          (product.price != null &&
              product.price! >= price.start &&
              product.price! <= price.end);
      bool matchesSize = size == null ||
          (product.size != null && product.size!.contains(size));

      return matchesText && matchesBrand && matchesPrice && matchesSize;
    }).toList();

    return searchList;
  }

  Future<List<Product>> loadProductUseBrand(String brand) async {
    var data = await rootBundle.loadString("assets/files/productList.json");
    var dataJson = jsonDecode(data);
    List<Product> proList = (dataJson['product'] as List)
        .map((e) => Product.fromJson(e))
        .where((element) =>
            element.brand!.toLowerCase().contains(brand.toLowerCase()))
        .toList();
    return proList;
  }

  Future<List<Product>> loadFavoritedProduct() async {
    List<Product> data = await SharePreHelper().getFavoriteItemList();
    return data;
  }
}
