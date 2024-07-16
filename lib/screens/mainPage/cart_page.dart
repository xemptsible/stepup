import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/screens/mainPage/checkout.dart';
import 'package:stepup/widgets/cartList/cart_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Giỏ hàng",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/search");
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            size: MediaQuery.of(context).size.height * 0.033,
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.notifications,
                          size: MediaQuery.of(context).size.height * 0.033,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          body: Consumer<ProductVMS>(
            builder: (context, value, child) {
              return Container(child: () {
                if (value.lst.isEmpty) {
                  return Center(
                    child: Container(
                      child: Image.network(
                          "https://newnet.vn/themes/newnet/assets/img/empty-cart.png"),
                    ),
                  );
                }
                return Container(
                  child: Column(
                    children: [
                      Expanded(flex: 4, child: CartList()),
                      Expanded(
                        flex: 1,
                        child: Container(
                            child: Column(
                          children: [
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Consumer<ProductVMS>(
                              builder: (BuildContext context, ProductVMS value,
                                  Widget? child) {
                                return Text(
                                  'Tổng Giá: ${NumberFormat('###,###.###').format(value.total)}đ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Consumer<ProductVMS>(
                              builder: (BuildContext context, ProductVMS value,
                                  Widget? child) {
                                return InkWell(
                                  onTap: () {
                                    value.getQuantity();
                                    // value.clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Checkout(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color:
                                              Color.fromARGB(255, 26, 28, 127)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.credit_card_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Thanh toán",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                );
              }());
            },
          )),
    );
  }
}
