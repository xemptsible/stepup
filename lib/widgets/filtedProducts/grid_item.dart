import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/favorite_vm.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';

class GridItem extends StatefulWidget {
  const GridItem({super.key, required this.product});

  final Product product;

  @override
  State<StatefulWidget> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  List<CartItem> proList = [];

  Future<List<CartItem>> _loadProData() async {
    SharePreHelper sharePreHelper = SharePreHelper();
    proList = await sharePreHelper.getCartItemList().then(
      (value) {
        Provider.of<ProductVMS>(context, listen: false)
            .listFromSharedPref(proList);
        Provider.of<ProductVMS>(context, listen: false).totalPrice();
        return proList;
      },
    );
    return proList;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FavoriteVm, ProductVMS>(
      builder: (context, favorite, cart, child) {
        CartItem cartItem = CartItem(product: widget.product, quantity: 1);
        bool isFavorited = favorite.isProductFavorited(widget.product);
        bool isInCart = cart.isInCart(cartItem);
        return const Card.outlined();
      },
    );
  }
}
