import 'package:flutter/material.dart';

class SizesVM with ChangeNotifier {
  int size = 0;
  select(int size) {
    this.size = size;
    print(size);
    notifyListeners();
  }
}
