import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/quantity_vm.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';

class ProductVMS with ChangeNotifier {
  SharePreHelper sharePreHelper = SharePreHelper();
  List<CartItem> lst = [];
  int total = 0;
  int quatity = 0;

  ListFromShared_pre(List<CartItem> cartList) async {
    lst = await cartList;
  }

  getQuantity() async {
    quatity = 0;
    await sharePreHelper.getCartItemList() as List<CartItem>;

    for (var element in lst) {
      quatity = quatity + element.quantity!;
    }

    notifyListeners();
  }

  add(CartItem pro) async {
    lst.add(pro);
    int tongGiaSoLuong = pro.product.price! * pro.quantity!;
    //Thêm vào share_pre

    await sharePreHelper.saveCartList(lst);

    //tổng giá giỏ hàng
    total += (tongGiaSoLuong);
    notifyListeners();
  }

  increaseCart(CartItem pro) async {
    pro.quantity! + 1;
    pro.setIncreaseQuantity(1);
    //save shared_pre
    await sharePreHelper.saveCartList(lst);

    // tong gia tien
    total += pro.product.price!;
    notifyListeners();
  }

  decreaseCart(CartItem pro) async {
    if (pro.quantity! <= 1) {
      print("số lượng 1");
    } else {
      pro.quantity! - 1;
      pro.setDecreaseQuantity(1);
      //save shared_pre

      await sharePreHelper.saveCartList(lst);

      //tổng giá
      total -= pro.product.price!;
    }
    notifyListeners();
  }

  totalPrice() async {
    total = 0;
    await sharePreHelper.getCartItemList() as List<CartItem>;

    for (var element in lst) {
      print(element.product.price);
      total = total + (element.product.price! * element.quantity!);
    }
  }

  del(int index) async {
    total -= lst[index].product.price! * lst[index].quantity!;
    lst.removeAt(index);
    if (total < 0) {
      total = 0;
    }
    await sharePreHelper.saveCartList(lst);
    print(index);
    notifyListeners();
  }

  clear() {
    total = 0;
    lst.clear();
    notifyListeners();
  }

  int proId = 0;
  select(int id) {
    proId = id;
    notifyListeners();
    print(proId);
  }
}
