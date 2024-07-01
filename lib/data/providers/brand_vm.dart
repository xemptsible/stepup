import 'package:flutter/material.dart';

class BrandsVM with ChangeNotifier {
  int selectedIndex = 0;
  select(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
