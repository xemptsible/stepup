import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/models/shoe.dart';

import 'package:stepup/utilities/const.dart';
import 'package:stepup/widgets/cartList/cart_item.dart';

Widget ListItemCart(BuildContext context, ShoeAPI shoe) {
  return SizedBox(
    height: 150,
    child: Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              color: Colors.grey,
              height: 150,
              width: 120,
              child: Image.network(shoe.Image),
              // child: thumbnail,
            ),
            Expanded(
              child: Container(
                // color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      // color: Colors.amber,
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.12,
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Shoe(
                          name: shoe.NameShoe!,
                          brand: shoe.Brand.toString(),
                          // discount: shoe.discount,
                          price: double.parse(shoe.Price.toString()),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      // color: Colors.amberAccent,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // color: Color.fromARGB(255, 57, 82, 196),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 26, 28, 127)),
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        )),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text("1")),
                                    Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                255, 26, 28, 127)),
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.all(3),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
