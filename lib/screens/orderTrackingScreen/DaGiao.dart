import 'package:flutter/material.dart';
import 'package:stepup/test/model/generator.dart';
import 'package:stepup/test/model/shoe.dart';
import 'package:stepup/widgets/filtedProducts/listItem.dart';


class DagiaoPage extends StatelessWidget {
  const DagiaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Shoe> shoes = generateShoe(5);
    return Scaffold(
        body: ListView.builder(
      itemCount: shoes.length,
      itemBuilder: (context, index) => ProductListItem(
          page: 1,
          thumbnail: Container(
            color: Colors.red,
          ),
          shoe: shoes[index]),
    ));
  }
}
