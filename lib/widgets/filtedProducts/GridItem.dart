// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:stepup/data/models/brand_model.dart';
import 'package:stepup/utilities/const.dart';

import '../../data/providers/provider.dart';

class GridItem extends StatefulWidget {
  final String brand;
  final String name;
  final int price;
  final String img;
  bool isFavorited = false;
  GridItem({
    Key? key,
    required this.brand,
    required this.name,
    required this.price,
    required this.isFavorited,
    required this.img,
  }) : super(key: key);

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  Brand? brand;
  Future<String> _loadBrandUseId() async {
    brand = await ReadData().getBrandById(int.parse(widget.brand));
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadBrandUseId(),
        builder: (context, snapshot) {
          return Align(
            child: Stack(children: [
              Positioned(
                child: Container(
                  height: 240,
                  width: 180,
                  child: Card.outlined(
                    shadowColor: Colors.black,
                    elevation: 5,
                    surfaceTintColor: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 22,
                          color: Colors.grey[200],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 110,
                          color: Colors.grey[200],
                          child: Image.asset(
                            urlimg + widget.img,
                            fit: BoxFit.cover,
                            width: 100,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    widget.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  brand != null ? brand!.name.toString() : '',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${NumberFormat('###,###.###').format(widget.price)} VND',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: widget.isFavorited
                          ? Icon(
                              size: 25,
                              Icons.favorite,
                              color: Colors.pink,
                            )
                          : Icon(size: 25, Icons.favorite_border),
                      onTap: () {
                        setState(() {
                          widget.isFavorited = !widget.isFavorited;
                        });
                      },
                    ),
                  )),
            ]),
          );
        });
  }
}
