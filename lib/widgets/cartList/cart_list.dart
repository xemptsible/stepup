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
        ) ??
        [];
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
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  itemCount: value.lst.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.only(right: 50),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Xóa khỏi giỏ hàng',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            value.del(index);
                          });
                        },
                        key: Key(
                          value.lst[index].product.name.toString(),
                        ),
                        child: itemListView(context, value.lst[index], index));
                  },
                ),
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
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SizedBox(
      child: Card.outlined(
        elevation: 3,
        shadowColor: Colors.black,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                // color: Color.fromARGB(255, 234, 233, 233),
                width: 120,
                child: Image.asset(
                  width: 100,
                  urlimg + shoe.product.img.toString(),
                  fit: BoxFit.cover,
                ),
                // child: thumbnail,
              ),
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      SizedBox(
                        // color: Colors.amber,
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.135,
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 10),
                          child: Shoe(
                            name: shoe.product.name!,
                            brand: shoe.product.brand.toString(),
                            // discount: shoe.discount,
                            price: double.parse(shoe.product.price.toString()),
                            size: shoe.size!,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        // color: Colors.amberAccent,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 10,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // color: Color.fromARGB(255, 57, 82, 196),
                                  child: QuantityWidget(
                                    shoe: shoe.product,
                                    quantity: shoe.quantity!,
                                    index: index,
                                  ),
                                ))
                          ],
                        ),
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
  );
}
