import 'package:flutter/material.dart';

class FilterVMS with ChangeNotifier {
  String brand = '';
  RangeValues price = RangeValues(0, 10);
  int size = 0;
  bool ascendingPrice = false;
  int brandSelectedIndex = 0;

  filt(String brand, RangeValues price, int size, bool ascendingPrice) {
    this.brand = brand;
    this.ascendingPrice = ascendingPrice;
    this.price = price;
    this.size = size;
    print(
        "${brand}, Gía: ${price}, Size: ${size}, Gía tăng: ${ascendingPrice}");
    notifyListeners();
  }

  selectSize(int size) {
    this.size = size;
    print(size);
    notifyListeners();
  }

  selectPrice(RangeValues price) {
    this.price = price;
    notifyListeners();
  }

  select(String brand, int index) {
    this.brandSelectedIndex = index;
    this.brand = brand;
    print(this.brand);
    notifyListeners();
  }
}
