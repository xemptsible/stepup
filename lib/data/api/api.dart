import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stepup/data/models/brand_model.dart';
import '../models/product_model.dart';

class ApiService {
  final String baseUrl = "https://api-giay-lemon.vercel.app";
  Future<List<Product>> fetchProducts() async {
    try {
      Dio api = Dio();
      Response response = await api.get(baseUrl + "/shoe");

      // Kiểm tra nếu response.data là danh sách
      if (response.data is List) {
        List<dynamic> data = response.data as List;
        return data.map((json) {
          return Product.fromJsonApi(json);
        }).toList();
      } else {
        throw Exception("Response data is not a list");
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<List<Product>> fetchProductsByBrand(String brand) async {
    try {
      Dio api = Dio();
      Response response = await api.get(baseUrl + "/shoe");

      // Kiểm tra nếu response.data là danh sách
      if (response.data is List) {
        List<dynamic> data = response.data as List;
        return data
            .map((json) {
              return Product.fromJsonApi(json);
            })
            .where((element) =>
                element.brand!.toLowerCase().contains(brand.toLowerCase()))
            .toList();
      } else {
        throw Exception("Response data is not a list");
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<List<Product>> searchProduct(
    String text, {
    String? brand,
    RangeValues? price,
    int? size,
  }) async {
    try {
      print(text);
      // Lấy danh sách sản phẩm từ API
      List<Product> proList = await fetchProducts();

      if (text != "" &&
          brand == "" &&
          size == 0 &&
          price == RangeValues(0.0, 10.0)) {
        return proList
            .where(
                (test) => test.name!.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
      // Lọc danh sách sản phẩm dựa trên từ khóa tìm kiếm và các tiêu chí khác
      List<Product> searchList = proList.where((product) {
        bool matchesText = product.name != null &&
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
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<List<Brand>> fetchBrands() async {
    try {
      Dio api = Dio();
      Response response = await api.get(baseUrl + "/brand");

      // Kiểm tra nếu response.data là danh sách
      if (response.data is List) {
        List<dynamic> data = response.data as List;
        return data.map((json) {
          return Brand.fromJson(json);
        }).toList();
      } else {
        throw Exception("Response data is not a list");
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
