import 'package:flutter/material.dart';

class BrandsVM with ChangeNotifier {
  int selectedIndex = 0;
  String selectedBrand = '';
  select(int index, String brand) {
    selectedIndex = index;
    selectedBrand = brand;
    notifyListeners();
  }
}
