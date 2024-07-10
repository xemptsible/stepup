// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class QuantityVMS with ChangeNotifier {
  int quantity;
  QuantityVMS({
    required this.quantity,
  });
  increase() {
    quantity++;
    notifyListeners();
  }

  decrease() {
    if (quantity <= 0) {
      quantity = 0;
    } else {
      quantity--;
    }
    notifyListeners();
  }
}
