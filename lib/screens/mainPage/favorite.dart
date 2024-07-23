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
  Future<String> _loadProData() async {
    proList = await ReadData().loadFavoritedProduct();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mong Muốn',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer<FavoriteVm>(
            builder: (context, myType, child) {
              return FutureBuilder(
                  future: _loadProData(),
                  builder: (BuildContext context, snapshot) {
                    return myType.favoriteLst.length > 0
                        ? SingleChildScrollView(
                            child: Container(
                              // height: MediaQuery.of(context).size.height,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: MediaQuery.of(context).size.height *
                                        0.78,
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
                                                      arguments:
                                                          proList[index]);
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
                        : Center(
                            child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "NO FAVORITE ITEM",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 54, 57, 99)),
                                ),
                              ],
                            ),
                          ));
                  });
            },
          ),
        ],
      ),
    );
  }
}
