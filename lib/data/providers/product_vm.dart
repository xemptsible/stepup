import 'package:flutter/material.dart';
import 'package:stepup/data/models/product_model.dart';

class ProductVMS with ChangeNotifier {
  List<Product> lst = [];
  int total = 0;
  add(Product pro) {
    lst.add(pro);
    print(pro.price);
    totalPrice();
    notifyListeners();
  }

  del(int index) {
    lst.removeAt(index);
    print(index);
    notifyListeners();
  }

  int proId = 0;
  select(int id) {
    proId = id;
    notifyListeners();
    print(proId);
  }

  totalPrice() {
    for (var element in lst) {
      total += element.price!;
    }
    notifyListeners();
  }
}
