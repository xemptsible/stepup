import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../shared_preferences/sharedPre.dart';

class FavoriteVm extends ChangeNotifier {
  List<Product> favoriteLst = [];
  SharePreHelper sharePreHelper = SharePreHelper();
  List<Product> get favoriteProducts => favoriteLst;

  bool isProductFavorited(Product product) {
    return favoriteLst.any((p) => p.id == product.id);
  }

  void addFavorite(Product product) async {
    if (!isProductFavorited(product)) {
      favoriteLst = await sharePreHelper.getFavoriteItemList();
      favoriteLst.add(product);
      await sharePreHelper.saveFavoriteList(favoriteLst);
      print("add ${product.name}");
      print(favoriteLst.length);
    } else {
      favoriteLst = await sharePreHelper.getFavoriteItemList();
      favoriteLst.removeWhere((pro) => pro.id == product.id);
      await sharePreHelper.saveFavoriteList(favoriteLst);
      print("remove ${product.name}");
      print(favoriteLst.length);
      notifyListeners();
    }
  }

  clear() async {
    favoriteLst.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('favorite');
    notifyListeners();
  }
}
