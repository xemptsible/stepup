import 'package:stepup/data/models/cart_item.dart';

class Order {
  final String email;
  final String nameUser;
  final int price;
  final DateTime dateOrder;
  final List<CartItem> items;

  Order({
    required this.email,
    required this.nameUser,
    required this.price,
    required this.dateOrder,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      email: json['Email'],
      nameUser: json['NameUser'],
      price: json['Price'],
      dateOrder: DateTime.parse(json['DateOrder'] as String),
      items: (json['Items'] as List<dynamic>)
          .map((item) => CartItem.fromJsonApi(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'NameUser': nameUser,
      'Price': price,
      'DateOrder': dateOrder.toIso8601String(),
      'Items': items.map((i) => i.toJsonApi()).toList(),
    };
  }
}
