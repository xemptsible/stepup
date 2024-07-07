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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Tin mới",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: 100,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/productsPage");
                },
                child: Text("see all")),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.24,
          child: BestSellerProductList(),
        ),
      ],
    );
  }
}
