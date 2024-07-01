import 'package:flutter/material.dart';
import 'package:stepup/test/listItem.dart';
import 'package:stepup/test/product_list.dart';

class DaHuyPage extends StatelessWidget {
  const DaHuyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: shoes.length,
      itemBuilder: (context, index) => ProductListItem(
          page: 3,
          thumbnail: Container(
            color: Colors.red,
          ),
          shoe: shoes[index]),
    ));
  }
}
