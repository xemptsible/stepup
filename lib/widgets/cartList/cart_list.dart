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
import 'package:stepup/widgets/cartList/cart_item_detail.dart';
import 'package:stepup/widgets/quantity_widget.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  Future<List<CartItem>> _loadProData() async {
    SharePreHelper sharePreHelper = SharePreHelper();
    List<CartItem> lstPro = await sharePreHelper.getCartItemList() ?? [];
    for (var element in lstPro) {
      print(element.product.name);
    }
    print(lstPro.length);
    await Provider.of<ProductVMS>(context, listen: false)
        .ListFromShared_pre(lstPro);
    return lstPro;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductVMS>(
      builder: (context, value, child) {
        if (value.lst.isEmpty) {
          return Center(
            child: Container(
              child: Image.network(
                  "https://newnet.vn/themes/newnet/assets/img/empty-cart.png"),
            ),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: value.lst.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                        padding: EdgeInsets.only(right: 50),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Remove from cart',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ],
                        )),
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
                      Container(
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
                      Container(
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
