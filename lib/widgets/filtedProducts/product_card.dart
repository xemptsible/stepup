import 'package:flutter/material.dart';
import 'package:stepup/data/models/brand_model.dart';
import 'package:stepup/utilities/const.dart';

import '../../data/providers/provider.dart';

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
  Brand? brand;
  Future<String> _loadBrand(int id) async {
    brand = await ReadData().getBrandById(id);
    return '';
  }

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
              margin: const EdgeInsets.only(top: 5),
              child: Image.asset(
                urlimg + image,
                fit: BoxFit.contain,
              ),
            )),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: double.maxFinite,
                        child: const Text(
                          "BEST SELLER",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        width: double.maxFinite,
                        child: Text(
                          "$priceĐ",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
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
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(20, 17, 126, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: const Text(
                  "+",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            )
          : const Positioned(
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
