import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stepup/data/models/account_model.dart';
import 'package:stepup/data/models/brand_model.dart';
import 'package:stepup/data/models/order_model.dart';
import '../models/product_model.dart';

class ApiService {
  final String baseUrl = "https://api-giay-lemon.vercel.app";
  final String baseUrlTest = "https://api-giay-order.vercel.app";
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

      if (text != "") {
        return proList
            .where(
                (test) => test.name!.toLowerCase().contains(text.toLowerCase()))
            .toList();
      } else if (brand == "Tất cả") {
        return proList.where((product) {
          bool matchesBrand =
              brand == null || brand == "Tất cả" || product.brand == brand;
          bool matchesPrice = price == null ||
              price == RangeValues(0, 0) ||
              (product.price != null &&
                  product.price! >= price.start &&
                  product.price! <= price.end);
          bool matchesSize = size == null ||
              size == 0 ||
              (product.size != null && product.size!.contains(size));

          return matchesBrand && matchesPrice && matchesSize;
        }).toList();
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

  Future<List<Order>> fetchOrder() async {
    try {
      Dio api = Dio();
      Response response = await api.get(baseUrlTest + "/order");

      List<dynamic> data = await response.data as List;

      return data.map((json) {
        return Order.fromJson(json);
      }).toList();
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<void> postOrder(Order order) async {
    try {
      Dio api = Dio();
      Response response = await api.post(
        baseUrlTest + "/order",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: order.toJson(),
      );

      if (response.statusCode == 200) {
        print('Order posted successfully');
      } else {
        print('Failed to post order. Status code: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<List<Account>> fetchAccount() async {
    try {
      Dio api = Dio();
      Response response = await api.get(baseUrlTest + "/account");

      List<dynamic> data = await response.data as List;

      return data.map((json) {
        print(json);
        return Account.fromJsonApi(json);
      }).toList();
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Account> getAccount(String email) async {
    try {
      Dio api = Dio();
      Response response = await api.get(baseUrlTest + "/account/" + email);
      return Account.fromJsonApi(response.data);
    } catch (e) {
      print('Error: $e');
      return Account();
    }
  }

  Future<void> postAccount(Account account) async {
    try {
      Dio api = Dio();

      Response response = await api.post(
        baseUrlTest + "/account",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: account.toJson(),
      );

      if (response.statusCode == 200) {
        print('Order posted successfully');
      } else {
        print('Failed to post order. Status code: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future updateAccount(Account account) async {
    try {
      Dio api = Dio();
      final response = await api.put(
        baseUrlTest + '/account/${account.Email}',
        data: account.toJson(),
      );
      print("Update thành công");
    } catch (e) {
      throw Exception('Failed to update account');
    }
  }
}
