import 'package:flutter/material.dart';

class BrandsVM with ChangeNotifier {
  int selectedIndex = 0;
  String selectedBrand = '';
  select(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  selectBrand(String brand) {
    selectedBrand = brand;
    notifyListeners();
  }
}
