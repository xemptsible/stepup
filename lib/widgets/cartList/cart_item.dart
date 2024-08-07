import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/brand_model.dart';
import '../../data/providers/provider.dart';

class Shoe extends StatelessWidget {
  final String name;
  final double price;
  // final double discount;
  final String brand;

  const Shoe(
      {super.key,
      required this.name,
      required this.price,
      // required this.discount,
      required this.brand});

  @override
  Widget build(BuildContext context) {
    Brand? brandData;
    Future<String> loadBrandUseId() async {
      brandData = await ReadData().getBrandById(int.parse(brand));
      return '';
    }

    return FutureBuilder(
        future: loadBrandUseId(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              Text(
                overflow: TextOverflow.ellipsis,
                brandData != null ? brandData!.name.toString() : '',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Text(
                "Cỡ giày: 44",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),

              // discount > 0
              //     ? Text(
              //         '$price VND',
              //         style: const TextStyle(
              //             fontSize: 11, decoration: TextDecoration.lineThrough),
              //       )
              Text(
                '${NumberFormat().format(price)} VND',
              ),
              // discount > 0 && discount < price
              //     ? Text(
              //         '$discount VND',
              //         style: const TextStyle(color: Colors.red),
              //       )
              //     : const SizedBox.shrink(),
            ],
          );
        });
  }
}
