import 'package:flutter/material.dart';

class ProductVMS with ChangeNotifier {
  int proId = 0;
  select(int id) {
    proId = id;
    notifyListeners();
    print(proId);
  }
}
