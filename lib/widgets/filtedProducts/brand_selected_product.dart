import 'package:flutter/material.dart';

import '../eventCarousel/best_seller_product_list.dart';

class BrandSelectPro extends StatefulWidget {
  const BrandSelectPro({super.key});

  @override
  State<BrandSelectPro> createState() => _BrandSelectProState();
}

class _BrandSelectProState extends State<BrandSelectPro> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tin mới",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        BestSellerProductList(),
      ],
    );
  }
}
