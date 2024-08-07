import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Shoe extends StatelessWidget {
  final String name;
  final double price;
  // final double discount;
  final String brand;
  final int size;

  const Shoe(
      {super.key,
      required this.name,
      required this.price,
      // required this.discount,
      required this.brand,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          brand,
        ),
        Text(
          "Size: $size",
        ),
        Text(
          '${NumberFormat('###,###.###').format(price)}đ',
        ),
        // discount > 0
        //     ? Text(
        //         '$price VND',
        //         style: const TextStyle(
        //             fontSize: 11, decoration: TextDecoration.lineThrough),
        //       )
        //     : Text(
        //         '$price VND',
        //       ),
        // discount > 0 && discount < price
        //     ? Text(
        //         '$discount VND',
        //         style: const TextStyle(color: Colors.red),
        //       )
        //     : const SizedBox.shrink(),
      ],
    );
  }
}
