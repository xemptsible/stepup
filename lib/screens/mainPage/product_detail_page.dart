// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
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
                              itemCount: 8,
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
                                        "${41 + index}",
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
                          ChangeNotifierProvider<QuantityVMS>(
                            create: (context) => QuantityVMS(quantity: 0),
                            child: QuantityWidget(),
                          ),
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
                              print(product.price);
                              value.add(product);
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.contact_support_sharp,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          "Liên hệ hỗ trợ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
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
      ),
    );
  }
}
