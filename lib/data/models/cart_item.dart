import 'package:stepup/data/models/product_model.dart';

class CartItem {
  final Product product;
  int? quantity;
  int? size;

  CartItem({required this.product, this.quantity, this.size});

  setIncreaseQuantity(int i) {
    quantity = quantity! + i;
    print("tang $quantity");
  }

  setDecreaseQuantity(int i) {
    if (quantity! <= 1) {
      print("Khong the tru");
    } else {
      quantity = quantity! - i;
      print("tang $quantity");
    }
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json["Shoe"]),
      quantity: json['Quantity'],
      size: json['Size'] ?? 40,
    );
  }

  factory CartItem.fromJsonApi(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJsonApi(json["Shoe"]),
      quantity: json['Quantity'],
      size: json['Size'] ?? 40,
    );
  }

  Map<String, dynamic> toJsonApi() {
    return {
      "Shoe": product.toJsonApi(),
      "Quantity": quantity,
      "Size": size,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "Shoe": product.toJson(),
      "Quantity": quantity,
      "Size": size,
    };
  }
}
