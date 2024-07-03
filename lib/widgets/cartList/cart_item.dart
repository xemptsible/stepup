import 'package:flutter/material.dart';

class Shoe extends StatelessWidget {
  final String name;
  final double price;

  final String brand;

  const Shoe(
      {super.key,
      required this.name,
      required this.price,
      required this.brand});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Text(
          brand,
        ),
        Text(
          '$price VND',
        ),
      ],
    );
  }
}
