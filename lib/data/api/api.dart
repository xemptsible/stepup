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
      Response response = await api.get("$baseUrl/shoe");

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
      rethrow;
    }
  }

  Future<List<Product>> fetchProductsByBrand(String brand) async {
    try {
      Dio api = Dio();
      Response response = await api.get("$baseUrl/shoe");

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
      rethrow;
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

      // Lọc danh sách sản phẩm dựa trên từ khóa tìm kiếm nếu có
      if (text.isNotEmpty) {
        proList = proList
            .where((product) =>
                product.name!.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }

      // Nếu không có tiêu chí lọc cụ thể, trả về danh sách đã lọc dựa trên từ khóa (nếu có)
      if (brand == "Tất cả" &&
          (price == null || price == const RangeValues(0, 0)) &&
          (size == null || size == 0)) {
        return proList;
      }

      // Lọc danh sách sản phẩm dựa trên các tiêu chí khác (brand, price, size)
      List<Product> filteredList = proList.where((product) {
        bool matchesBrand =
            brand == null || brand == "Tất cả" || product.brand == brand;

        // Kiểm tra giá chỉ khi price không phải là RangeValues(0, 0)
        bool matchesPrice = price == null ||
            (price.start == 0 && price.end == 0) ||
            (product.price != null &&
                product.price! >= price.start &&
                product.price! <= price.end);

        bool matchesSize = size == null ||
            size == 0 ||
            (product.size != null && product.size!.contains(size));

        return matchesBrand && matchesPrice && matchesSize;
      }).toList();

      return filteredList;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<List<Brand>> fetchBrands() async {
    try {
      Dio api = Dio();
      Response response = await api.get("$baseUrl/brand");

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
      rethrow;
    }
  }

  Future<List<Order>> fetchOrder() async {
    try {
      Dio api = Dio();
      Response response = await api.get("$baseUrlTest/order");

      List<dynamic> data = await response.data as List;

      return data.map((json) {
        return Order.fromJson(json);
      }).toList();
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Order>> getOrderByEmail(String email) async {
    try {
      Dio api = Dio();
      Response response = await api.get("$baseUrlTest/order/$email");

      List<dynamic> data = await response.data;

      return data.map((json) {
        print(json);
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
        "$baseUrlTest/order",
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
      Response response = await api.get("$baseUrlTest/account");

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
      Response response = await api.get("$baseUrlTest/account/$email");
      print(response.data);
      Account curAcc = Account.fromJsonApi(response.data);
      print("Current User: ${curAcc.Email!}");
      return curAcc;
    } catch (e) {
      print('Error: $e' "lỗi api");
      return Account();
    }
  }

  Future<int?> postAccount(Account account) async {
    try {
      Dio api = Dio();

      Response response = await api.post(
        "$baseUrlTest/account",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: account.toJsonPost(),
      );

      if (response.statusCode == 200) {
        print('Account posted successfully');
        return response.statusCode;
      } else {
        print('Failed to post order. Status code: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
      return response.statusCode;
    } catch (e) {
      print('Error occurred: $e' "lỗi đăng ký tài khoản api");
    }
    return null;
  }

  Future updateAccount(Account account) async {
    try {
      Dio api = Dio();
      await api
          .put(
        '$baseUrlTest/account/${account.Email}',
        data: account.toJson(),
      )
          .then(
        (res) {
          if (res.statusCode == 200) {
            print("Update thành công");
          }
        },
      );
    } catch (e) {
      throw Exception('Failed to update account');
    }
  }
}
