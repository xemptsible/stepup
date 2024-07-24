import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/favorite_vm.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';
import 'package:stepup/utilities/const.dart';

class GridItem2 extends StatefulWidget {
  const GridItem2({super.key, required this.product});

  final Product product;

  @override
  State<StatefulWidget> createState() => _GridItem2State();
}

class _GridItem2State extends State<GridItem2> {
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
        return Card.outlined(
          elevation: 8,
          surfaceTintColor: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              "/productDetail",
              arguments: widget.product,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 36),
                      color: Colors.grey[200],
                      child: Image.asset(
                        height: 120,
                        width: double.infinity,
                        urlimg + widget.product.img!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Icon(Icons.hide_image_outlined),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.product.name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.product.brand!),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              '${NumberFormat('###,###.###').format(widget.product.price!)}đ',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    elevation: 18,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      onPressed: () {},
                      color: Theme.of(context).primaryColor,
                      minWidth: 48,
                      height: 48,
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

                

                // InkWell(
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(20),
                //     ),
                //     onTap: () => print('test'),
                //     child: Ink(
                //       decoration: BoxDecoration(
                //           boxShadow: const [
                //             BoxShadow(offset: Offset(1, 3), blurRadius: 10)
                //           ],
                //           borderRadius: const BorderRadius.only(
                //             topLeft: Radius.circular(20),
                //           ),
                //           color: Theme.of(context).primaryColor),
                //       height: 48,
                //       width: 48,
                //       child: const Icon(
                //         Icons.add,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),