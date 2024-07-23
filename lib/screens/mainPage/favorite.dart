// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/favorite_vm.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/widgets/filtedProducts/GridItem.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Product> proList = [];
  late Future products;

  Future<List<Product>> _loadProData() async {
    proList = await ReadData().loadFavoritedProduct();
    return proList;
  }

  @override
  void initState() {
    super.initState();
    products = _loadProData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<FavoriteVm>(
          builder: (context, myType, child) {
            return FutureBuilder(
              future: products,
              builder: (BuildContext context, snapshot) {
                return myType.favoriteLst.isNotEmpty
                    ? SingleChildScrollView(
                        child: Container(
                          // height: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                height:
                                    MediaQuery.of(context).size.height * 0.78,
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
                                                  context, "/productDetail",
                                                  arguments: proList[index]);
                                            },
                                            child: GridItem(
                                                product: proList[index]),
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
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.favorite_border,
                              size: 100,
                              color: Colors.black38,
                            ),
                            Text(
                              "Không có sản phẩm yêu thích",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 54, 57, 99)),
                            ),
                          ],
                        ),
                      );
              },
            );
          },
        ),
      ],
    );
  }
}
