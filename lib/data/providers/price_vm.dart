import 'package:flutter/material.dart';

class PriceVMS with ChangeNotifier {
  RangeValues price = RangeValues(0, 10);
  select(RangeValues price) {
    this.price = price;
    notifyListeners();
  }
}
