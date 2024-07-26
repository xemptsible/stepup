import 'package:flutter/material.dart';

class FilterVMS with ChangeNotifier {
  String brand = 'Tất cả';
  RangeValues price = const RangeValues(100000, 3000000);
  int size = 40;
  bool ascendingPrice = false;
  int brandSelectedIndex = 0;
  int sizeIndex = 0;
  filt(String brand, RangeValues price, int size, bool ascendingPrice) {
    this.brand = brand;
    this.ascendingPrice = ascendingPrice;
    this.price = price;
    this.size = size;
    print(
        "$brand, Gía: $price, Size: $size, Gía tăng: $ascendingPrice");
    notifyListeners();
  }

  bool isSelectedSize(int index) {
    print("size: $sizeIndex, index: $index");
    return sizeIndex == index ? true : false;
  }

  selectSize(int size) {
    this.size = size;
    print("size: $size, ");
    notifyListeners();
  }

  selectPrice(RangeValues price) {
    this.price = price;
    notifyListeners();
  }

  removeSizeFilter() {
    size = 0;
    notifyListeners();
  }

  removePriceFilter() {
    price = const RangeValues(0, 0);
    notifyListeners();
  }

  select(String brand, int index) {
    brandSelectedIndex = index;
    this.brand = brand;
    print(this.brand);
    notifyListeners();
  }
}
