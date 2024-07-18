import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/quantity_vm.dart';

class ProductVMS with ChangeNotifier {
  List<CartItem> lst = [];
  int total = 0;
  int quatity = 0;

  getQuantity() {
    for (var element in lst) {
      quatity = quatity + element.quantity!;
    }
    notifyListeners();
  }

  add(CartItem pro) {
    lst.add(pro);
    int tongGiaSoLuong = pro.product.price! * pro.quantity!;
    total += (tongGiaSoLuong);
    notifyListeners();
  }

  increaseCart(CartItem pro) {
    pro.quantity! + 1;
    pro.setIncreaseQuantity(1);
    total += pro.product.price!;
    // print(pro.quantity);
    // print(pro.product.name);
    notifyListeners();
  }

  decreaseCart(CartItem pro) {
    if (pro.quantity! <= 1) {
      print("số lượng 1");
    } else {
      pro.quantity! - 1;
      pro.setDecreaseQuantity(1);
      total -= pro.product.price!;
    }
    notifyListeners();
  }

  totalPrice() {
    total = 0;
    for (var element in lst) {
      total = total + (element.product.price! * element.quantity!);
    }
  }

  // incrementCart(Product pro, int quantity) {
  //   total += pro.price!;
  //   notifyListeners();
  // }

  // decrementCart(Product pro, int quantity) {
  //   total -= pro.price!;
  //   notifyListeners();
  // }

  // incrementPro() {
  //   quantity++;
  //   notifyListeners();
  // }

  // decreasePro() {
  //   if (quantity <= 0) {
  //     quantity = 0;
  //   } else {
  //     quantity--;
  //   }
  //   notifyListeners();
  // }

  del(int index) {
    total -= lst[index].product.price! * lst[index].quantity!;
    lst.removeAt(index);
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
