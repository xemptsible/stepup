import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/providers/brand_vm.dart';
import 'package:stepup/data/providers/favorite_vm.dart';
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
  List<Product> proFavoritedLst = [];
  bool isLoading = false;
  Future<String> _loadProData() async {
    ApiService apiService = ApiService();
    isLoading = true;
    proList = await ReadData().loadProductData();
    if (proList.length > 6) {
      proList = proList.sublist(0, 6);
    }
    isLoading = false;
    return '';
  }

  Future<String> _loadProDataUseBrand(String name) async {
    isLoading = true;
    proList = await ReadData().loadProductUseBrand(name);
    isLoading = false;
    if (proList.length > 6) {
      proList = proList.sublist(0, 6);
    }
    return '';
  }

  Future<String> _loadUserFavoriteList() async {
    try {
      proFavoritedLst = await ReadData().loadFavoritedProduct();
      print(proFavoritedLst.length);
    } catch (e) {
      print(e);
    }
    return '';
  }

  bool isFavorited(Product pro) {
    var checkFavList = proFavoritedLst.where((e) => e.id == pro.id);
    if (checkFavList.length > 0) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProDataUseBrand("Nike");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandsVM>(
      builder: (context, brandVM, child) {
        return FutureBuilder(
          future: brandVM.selectedIndex == 0
              ? _loadProData()
              : _loadProDataUseBrand(brandVM.selectedBrand),
          builder: (BuildContext context, snapshot) {
            return isLoading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.only(top: 5),
                      height: MediaQuery.of(context).size.height * 0.36,
                      child: Consumer<FavoriteVm>(
                        builder: (context, productVM, child) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.8,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 1,
                            ),
                            itemCount: proList.length,
                            itemBuilder: (context, index) {
                              final product = proList[index];
                              final isFavorited = proFavoritedLst
                                  .any((e) => e.id == product.id);

                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/productDetail",
                                      arguments: product);
                                },
                                onLongPress: () => print('a'),
                                child: Center(
                                    child: GridItem(
                                  product: product,
                                )),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
