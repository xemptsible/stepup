import 'package:flutter/material.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/models/account_model.dart';

class AccountVMS with ChangeNotifier {
  Account? currentAcc;

  Future setCurrentAcc(String email) async {
    ApiService apiService = ApiService();
    currentAcc = await apiService.getAccount(email);
    notifyListeners();
  }

  updateCurrentAcc() async {
    ApiService apiService = ApiService();
    await apiService.updateAccount(currentAcc!);
    notifyListeners();
  }

  setImage(String img) {
    currentAcc!.setImage(img);
    notifyListeners();
  }
}
