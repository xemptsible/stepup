import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepup/data/models/product_model.dart';

import 'package:stepup/utilities/const.dart';
import 'package:stepup/widgets/cartList/cart_item.dart';

Widget ListItemDaHuy(BuildContext context, Product shoe) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SizedBox(
      height: 160,
      child: Card.outlined(
        elevation: 3,
        shadowColor: Colors.black,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                color: Color.fromARGB(255, 234, 233, 233),
                height: 160,
                width: 120,
                child: Image.asset(
                  width: 100,
                  urlimg + shoe.img.toString(),
                  fit: BoxFit.contain,
                ),
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
                        height: MediaQuery.sizeOf(context).height * 0.135,
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 10),
                          child: Shoe(
                            name: shoe.name!,
                            brand: shoe.brand.toString(),
                            // discount: shoe.discount,
                            price: double.parse(shoe.price.toString()),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
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
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.topCenter,
                width: 50,
                child: Icon(
                  Icons.more_vert_outlined,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
