import 'package:stepup/data/models/cart_item.dart';

class Order {
  final String nameUser;
  final List<CartItem> items;

  Order({
    required this.nameUser,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      nameUser: json['NameUser'],
      items:
          (json['Items'] as List).map((i) => CartItem.fromJsonApi(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NameUser': nameUser,
      'Items': items.map((i) => i.toJsonApi()).toList(),
    };
  }
}
