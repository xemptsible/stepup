// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:stepup/utilities/const.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final double width;
  final double height;
  bool isFavorited;
  ProductCard(
      {super.key,
      this.isFavorited = false,
      this.width = 150,
      this.height = 220,
      required this.image,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        clipBehavior: Clip.antiAlias,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 5),
              child: Image.asset(
                urlimg + image,
                fit: BoxFit.contain,
              ),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "BEST SELLER",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        width: double.maxFinite,
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        width: double.maxFinite,
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "${price}Đ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        width: double.maxFinite,
                      ))
                ],
              ),
            )),
          ],
        ),
      ),
      !isFavorited
          ? Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(20, 17, 126, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            )
          : Positioned(
              top: 10,
              left: 10,
              child: Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
            ),
    ]);
  }
}
