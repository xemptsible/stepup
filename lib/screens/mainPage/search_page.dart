import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/widgets/filtedProducts/product_list.dart';

import '../../data/models/product_model.dart';
import '../../data/providers/provider.dart';
import '../../widgets/filtedProducts/GridItem.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> proList = [];
  TextEditingController _searchController = TextEditingController();
  String searchText = '';
  Future<String> _loadProData(String text) async {
    proList = await ReadData().searchProduct(text);
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Tìm kiếm"),
            ),
            body: SingleChildScrollView(
              child: ChangeNotifierProvider<ProductVMS>(
                create: (context) => ProductVMS(),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchController.text;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(Icons.search)),
                            ),
                            Expanded(
                                child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Nhập từ khóa ở đây',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .transparent), // Tắt gạch dưới khi không focus
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .transparent), // Tắt gạch dưới khi focus
                                ),
                              ),
                            )),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.filter_alt_outlined)),
                          ],
                        ),
                      ),
                      FutureBuilder(
                          future: _loadProData(_searchController.text),
                          builder: (BuildContext context, snapshot) {
                            return SingleChildScrollView(
                              child: _searchController.text == ''
                                  ? Container()
                                  : Container(
                                      // height: MediaQuery.of(context).size.height,
                                      color: Colors.white,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.78,
                                            child: Container(
                                                child: Consumer<ProductVMS>(
                                              builder:
                                                  (context, myType, child) {
                                                return GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 0.8,
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 1,
                                                  ),
                                                  itemCount: proList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Center(
                                                      child: Container(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                "/productDetail",
                                                                arguments:
                                                                    proList[
                                                                        index]);
                                                          },
                                                          child: GridItem(
                                                              isFavorited:
                                                                  false,
                                                              img: proList[
                                                                      index]
                                                                  .img
                                                                  .toString(),
                                                              brand: proList[
                                                                      index]
                                                                  .brand
                                                                  .toString(),
                                                              name: proList[
                                                                      index]
                                                                  .name
                                                                  .toString()
                                                                  .trim(),
                                                              price: proList[
                                                                          index]
                                                                      .price
                                                                  as int),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
