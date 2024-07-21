import 'package:stepup/data/models/product_model.dart';

class CartItem {
  final Product product;
  int? quantity;
  int? size;

  CartItem({required this.product, this.quantity, this.size});

  setIncreaseQuantity(int i) {
    this.quantity = quantity! + i;
    print("tang ${this.quantity}");
  }

  setDecreaseQuantity(int i) {
    if (this.quantity! <= 1) {
      print("Khong the tru");
    } else {
      this.quantity = quantity! - i;
      print("tang ${this.quantity}");
    }
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json["product"]),
      quantity: json['quantity'],
      size: json['size'] ?? 40,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product": product.toJson(),
      "quantity": quantity,
      "size": size,
    };
  }
}
