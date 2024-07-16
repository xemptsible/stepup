// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/providers/quantity_vm.dart';
import 'package:stepup/utilities/const.dart';

import '../../widgets/expandable_text.dart';
import '../../widgets/quantity_widget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isSelected = false;
  int selectedIndex = 1;
  int quantity = 1;

  increasePro() {
    quantity++;
    print(quantity);
  }

  decreasetPro() {
    if (quantity == 1) {
      print("quantity ${quantity}");
    } else {
      quantity--;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    Widget quantityPro() {
      return Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                decreasetPro();
              });
            },
            child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 26, 28, 127)),
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                )),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(quantity.toString())),
          InkWell(
            onTap: () {
              // value.incrementPro();
              // value.incrementCart(widget.shoe, value.quantity);
              setState(() {
                increasePro();
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 26, 28, 127)),
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.all(3),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ),
        ],
      );
    }

    // Build Page
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 214, 214, 214),
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(urlimg + product.img!),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      maxLines: 3,
                                      product.name.toString(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      "${NumberFormat().format(product.price)} đ",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: isSelected
                                  ? Icon(
                                      size: 35,
                                      Icons.favorite,
                                      color: Colors.pink,
                                    )
                                  : Icon(size: 40, Icons.favorite_border),
                              onTap: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Kích cỡ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Container(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.size!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                    width: 45,
                                    margin: EdgeInsets.only(right: 20),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "${product.size![index]}",
                                      style: TextStyle(
                                          color: selectedIndex == index
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    decoration: BoxDecoration(
                                      border: selectedIndex == index
                                          ? null
                                          : Border.all(),
                                      shape: BoxShape.circle,
                                      color: selectedIndex == index
                                          ? Color.fromRGBO(53, 114, 239, 1)
                                          : Colors.white,
                                    )),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Số lượng",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        quantityPro(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Consumer<ProductVMS>(
                    builder: (BuildContext context, ProductVMS value,
                        Widget? child) {
                      return Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 26, 28, 127)),
                          onPressed: () {
                            CartItem cartItem =
                                CartItem(product: product, quantity: quantity);
                            print(product.price! * quantity);
                            value.add(cartItem);

                            DiaglogCustom(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Thêm vào giỏ hàng",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Thông tin sản phẩm",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: ExpandableText(
                          text: product.des.toString(),
                        )),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                              textAlign: TextAlign.start, "Có thắc mắc ?")),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Container(
                            alignment: Alignment.center,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {},
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.contact_support_sharp,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Liên hệ hỗ trợ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  )),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

void DiaglogCustom(BuildContext context) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: Text(
              "Thêm Giỏ Hàng Thành Công",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
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
                    color: Color.fromARGB(255, 32, 74, 150)),
                child: Text(
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
