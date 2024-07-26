import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/data/providers/quantity_vm.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';
import 'package:stepup/test/model/shoe.dart';
import 'package:stepup/utilities/const.dart';
import 'package:stepup/widgets/quantity_widget.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  late Future cart;

  Future<List<CartItem>> _loadCartData() async {
    SharePreHelper sharePreHelper = SharePreHelper();
    List<CartItem> lstPro = await sharePreHelper.getCartItemList().then(
      (cart) {
        return Provider.of<ProductVMS>(context, listen: false)
            .listFromSharedPref(cart);
      },
    );
    for (var element in lstPro) {
      print(element.product.name);
    }
    print(lstPro.length);

    return lstPro;
  }

  @override
  void initState() {
    super.initState();
    cart = _loadCartData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cart,
      builder: (BuildContext context, snapshot) {
        return Consumer<ProductVMS>(
          builder: (context, value, child) {
            if (value.lst.isEmpty) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.black38,
                  ),
                  Text(
                    "Giỏ hàng rỗng",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              );
            } else {
              return ListView.builder(
                itemCount: value.lst.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red[800],
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Xóa khỏi giỏ hàng',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          value.del(index);
                        });
                      },
                      key: UniqueKey(),
                      // Key(
                      //   value.lst[index].product.name.toString(),
                      // ),
                      child: itemListView(context, value.lst[index], index));
                },
              );
            }
          },
        );
      },
    );
  }
}

Widget itemListView(BuildContext context, CartItem shoe, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Card.outlined(
      elevation: 4,
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                  border: Border.all(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Colors.grey.shade300),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  height: 120,
                  width: 120,
                  urlimg + shoe.product.img.toString(),
                  fit: BoxFit.fitWidth,
                ),
                // child: thumbnail,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shoe(
                        name: shoe.product.name!,
                        brand: shoe.product.brand.toString(),
                        // discount: shoe.discount,
                        price: double.parse(shoe.product.price.toString()),
                        size: shoe.size!,
                      ),
                      Row(
                        children: [
                          Card.filled(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: QuantityWidget(
                                shoe: shoe.product,
                                quantity: shoe.quantity!,
                                index: index,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
