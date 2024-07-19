import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/models/product_model.dart';
import '../../data/providers/favorite_vm.dart';
import '../../utilities/const.dart';

class GridItem extends StatelessWidget {
  final Product product;

  GridItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteVm>(
      builder: (context, favoriteVm, child) {
        final isFavorited = favoriteVm.isProductFavorited(product);

        return Align(
          child: Stack(children: [
            Positioned(
              child: Container(
                height: 240,
                width: 180,
                child: Card.outlined(
                  shadowColor: Colors.black,
                  elevation: 5,
                  surfaceTintColor: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 22,
                        color: Colors.grey[200],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        color: Colors.grey[200],
                        child: Image.asset(
                          urlimg + product.img!,
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  product.name!,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                product.brand!,
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${NumberFormat('###,###.###').format(product.price!)}đ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 10,
                right: 10,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Icon(
                      size: 25,
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.pink : null,
                    ),
                    onTap: () {
                      favoriteVm.addFavorite(product);
                    },
                  ),
                )),
          ]),
        );
      },
    );
  }
}
