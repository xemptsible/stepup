// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/widgets/filtedProducts/GridItem.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Product> proList = [];
  Future<String> _loadProData() async {
    proList = await ReadData().loadProductData();
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Mong muốn",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/search");
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            size: MediaQuery.of(context).size.height * 0.033,
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.notifications,
                          size: MediaQuery.of(context).size.height * 0.033,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        FutureBuilder(
            future: _loadProData(),
            builder: (BuildContext context, snapshot) {
              return SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: MediaQuery.of(context).size.height * 0.78,
                        child: Container(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.8,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 1,
                            ),
                            itemCount: proList.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/productDetail");
                                    },
                                    child: GridItem(
                                        isFavorited: true,
                                        img: proList[index].img.toString(),
                                        brand: proList[index].brand.toString(),
                                        name: proList[index]
                                            .name
                                            .toString()
                                            .trim(),
                                        price: proList[index].price as int),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
