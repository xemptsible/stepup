import 'package:stepup/data/models/product_model.dart';

class CartItem {
  final Product product;
  int? quantity;

  CartItem({required this.product, this.quantity});
}
