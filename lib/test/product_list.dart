import 'package:flutter/material.dart';
import 'package:stepup/test/listItem.dart';
import 'package:stepup/test/model/generator.dart';
import 'package:stepup/test/model/shoe.dart';

List<Shoe> shoes = generateShoe(5);

class ListProductScreen extends StatelessWidget {
  const ListProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: shoes.length,
      itemBuilder: (context, index) => ProductListItem(
          thumbnail: Container(
            color: Colors.red,
          ),
          shoe: shoes[index]),
    ));
  }
}

// ListView(
//         padding: const EdgeInsets.all(8),
//         children: <Widget>[
//           ProductListItem(
//               thumbnail: Container(
//                 color: Colors.red,
//               ),
//               name: "MELO x DEXTER'S LAB MB.03 Men's Basketball Shoes",
//               price: 3,
//               discount: 0,
//               brand: 'Nike'),
//           ProductListItem(
//               thumbnail: Container(
//                 color: Colors.red,
//               ),
//               name: "MELO x DEXTER'S LAB MB.03 Men's Basketball Shoes",
//               price: 3,
//               discount: 0,
//               brand: 'Nike')
//         ],
//       ),