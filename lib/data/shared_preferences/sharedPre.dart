import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/providers/product_vm.dart';

import 'package:stepup/data/shared_preferences/user.dart';

class SharePreHelper {
  saveData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strUser = jsonEncode(user);
    prefs.setString("user", strUser);
    print("Luu thanh cong");
  }

  Future<User> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strUser = prefs.getString("user");

    return User.fromJson(jsonDecode(strUser!));
  }

  // ________________________________________________________________________________
  // CART PAGE //

  // Future saveCart(CartItem cartItem) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String strCart = jsonEncode(cartItem);
  //   prefs.setString("cart", strCart);
  //   print("Lưu giỏ hàng thành công");
  // }

  // Future<CartItem> getCart() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? strCart = prefs.getString("cart");

  //   return CartItem.fromJson(jsonDecode(strCart!));
  // }

  //list cart
  Future saveCartList(List<CartItem> cartList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> strCartItemList =
        cartList.map((cartItem) => jsonEncode(cartItem.toJson())).toList();
    prefs.setStringList("cart", strCartItemList);
    print("Lưu giỏ hàng thành công");
  }

  Future<List<CartItem>> getCartItemList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? strCartItemList = await prefs.getStringList("cart");
    if (strCartItemList != null) {
      return strCartItemList
          .map((strCartItem) => CartItem.fromJson(jsonDecode(strCartItem)))
          .toList();
    }
    return [];
  }
}
