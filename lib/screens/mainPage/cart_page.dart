import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/api/api.dart';

import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/order_model.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/data/shared_preferences/sharedPre.dart';
import 'package:stepup/screens/mainPage/checkout.dart';
import 'package:stepup/widgets/cartList/cart_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> proList = [];
  List<Order> orderList = [];

  late Future cart;
  late Future product;

  Future<List<CartItem>> _loadProData() async {
    SharePreHelper sharePreHelper = SharePreHelper();
    proList = await sharePreHelper.getCartItemList().then(
      (list) {
        Provider.of<ProductVMS>(context, listen: false)
            .listFromSharedPref(proList);
        Provider.of<ProductVMS>(context, listen: false).totalPrice();
        return proList;
      },
    );

    return proList;
  }

  Future<List<Order>> _loadOrderData() async {
    ApiService apiService = ApiService();
    orderList = await ReadData().loadOrderData();

    return orderList;
  }

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
    product = _loadProData();
    cart = _loadCartData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cart,
      builder: (BuildContext context, snapshot) {
        return Column(
          children: [
            const Expanded(child: CartList()),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(236, 236, 243, 0.612),
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black26),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Consumer<ProductVMS>(
                      builder: (BuildContext context, ProductVMS value,
                          Widget? child) {
                        return Text(
                          'Tổng giá: ${NumberFormat('###,###.###').format(value.total)}đ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Consumer<ProductVMS>(
                        builder: (BuildContext context, ProductVMS value,
                            Widget? child) {
                          return Row(
                            children: [
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () {
                                    value.getQuantity();
                                    // value.clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Checkout(),
                                      ),
                                    );
                                  },
                                  label: const Text('Thanh toán'),
                                  icon: const Icon(Icons.payment),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
