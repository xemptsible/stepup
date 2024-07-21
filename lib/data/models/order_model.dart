import 'package:stepup/data/models/cart_item.dart';

class Order {
  final String email;
  final String nameUser;
  final List<CartItem> items;

  Order({
    required this.email,
    required this.nameUser,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      email: json['Email'],
      nameUser: json['NameUser'],
      items:
          (json['Items'] as List).map((i) => CartItem.fromJsonApi(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'NameUser': nameUser,
      'Items': items.map((i) => i.toJsonApi()).toList(),
    };
  }
}
