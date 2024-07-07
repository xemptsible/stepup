import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepup/data/providers/brand_vm.dart';
import 'package:stepup/widgets/filtedProducts/GridItem.dart';

import '../../data/models/product_model.dart';
import '../../data/providers/product_vm.dart';
import '../../data/providers/provider.dart';
import 'package:provider/provider.dart';

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

  Future<String> _loadProDataUseBrand(int id) async {
    proList = await ReadData().loadProductUseBrand(id);
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProDataUseBrand(1);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandsVM>(
      builder: (context, value, child) {
        return FutureBuilder(
            future: value.selectedIndex == 0
                ? _loadProData()
                : _loadProDataUseBrand(value.selectedIndex),
            builder: (BuildContext context, snapshot) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.only(top: 5),
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: Container(child: Consumer<ProductVMS>(
                    builder: (context, value, child) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 1,
                        ),
                        itemCount: proList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/productDetail",
                                  arguments: proList[index]);
                              // value.select(
                              //     int.parse(proList[index].id.toString()));
                            },
                            child: Center(
                              child: GridItem(
                                  isFavorited: false,
                                  img: proList[index].img.toString(),
                                  brand: proList[index].brand.toString(),
                                  name: proList[index].name.toString().trim(),
                                  price: proList[index].price as int),
                            ),
                          );
                        },
                      );
                    },
                  )),
                ),
              );
            });
      },
    );
  }
}
