// định nghĩa model
import 'dart:convert';

class ShoeAPI {
  final String NameShoe;
  final int Price;
  final int Size;
  final String Brand;
  final String Image;

  ShoeAPI({
    required this.NameShoe,
    required this.Price,
    required this.Size,
    required this.Brand,
    required this.Image,
  });

  factory ShoeAPI.fromJson(Map<String, dynamic> json) {
    return ShoeAPI(
      NameShoe: json['NameShoe'],
      Price: json['Price'],
      Size: json['Size'],
      Brand: json['Brand'],
      Image: json['Image'],
    );
  }
}
