import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';

import '../../data/models/cart_item.dart';
import '../../data/models/product_model.dart';
import '../../data/providers/favorite_vm.dart';
import '../../utilities/const.dart';

class OldGridItem extends StatefulWidget {
  final Product product;

  const OldGridItem({
    super.key,
    required this.product,
  });

  @override
  State<OldGridItem> createState() => _OldGridItemState();
}

List<CartItem> proList = [];

class _OldGridItemState extends State<OldGridItem> {
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
  void initState() {
    super.initState();
    _loadProData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteVm>(
      builder: (context, favoriteVm, child) {
        bool isFavorited = favoriteVm.isProductFavorited(widget.product);

        return Align(
          child: Stack(
            children: [
              Positioned(
                child: SizedBox(
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
                            urlimg + widget.product.img!,
                            fit: BoxFit.cover,
                            width: 100,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    widget.product.name!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  widget.product.brand!,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${NumberFormat('###,###.###').format(widget.product.price!)}đ',
                                      style: const TextStyle(
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
                        setState(() {
                          favoriteVm.addFavorite(widget.product);
                          isFavorited =
                              favoriteVm.isProductFavorited(widget.product);
                        });
                      },
                    ),
                  )),
              Positioned(
                bottom: 6,
                right: 6,
                child: Consumer<ProductVMS>(
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () {
                        CartItem cartItem =
                            CartItem(product: widget.product, quantity: 1);
                        print(
                            "${widget.product.name!} / ${widget.product.price}");
                        value.add(cartItem);

                        dialogGioHang(context);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(offset: Offset(1, 3), blurRadius: 4)
                            ],
                            color: Color.fromARGB(255, 32, 74, 150),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(10),
                            )),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void dialogGioHang(BuildContext context) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: SizedBox(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: const Text(
              "Thêm giỏ hàng thành công",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Image.network(
                width: 150,
                height: 150,
                "https://cdn4.iconfinder.com/data/icons/e-commerce-and-shopping-3/500/cart-checked-512.png"),
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width * 0.7,
                height: MediaQuery.sizeOf(context).height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 32, 74, 150)),
                child: const Text(
                  'Trở về',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ))
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}
