import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepup/widgets/filtedProducts/GridItem.dart';

import '../../data/models/product_model.dart';
import '../../data/providers/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
    return FutureBuilder(
        future: _loadProData(),
        builder: (BuildContext context, snapshot) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: MediaQuery.of(context).size.height * 0.36,
                    child: Container(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                    isFavorited: false,
                                    img: proList[index].img.toString(),
                                    brand: proList[index].brand.toString(),
                                    name: proList[index].name.toString().trim(),
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
        });
  }
}
