import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../eventCarousel/best_seller_product_list.dart';

class BrandSelectPro extends StatefulWidget {
  const BrandSelectPro({super.key});

  @override
  State<BrandSelectPro> createState() => _BrandSelectProState();
}

class _BrandSelectProState extends State<BrandSelectPro> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tin mới",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
          child: const BestSellerProductList(),
        ),
      ],
    );
  }
}
