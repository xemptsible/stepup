import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/providers/filter_vm.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/widgets/filtedProducts/grid_item.dart';

import 'package:stepup/widgets/filter/filter_widget.dart';

import '../../data/models/product_model.dart';
import '../../data/providers/provider.dart';

class NewSearchPage extends StatefulWidget {
  const NewSearchPage({super.key});

  @override
  State<NewSearchPage> createState() => _NewSearchPageState();
}

class _NewSearchPageState extends State<NewSearchPage> {
  bool isSearchMode = false;

  final TextEditingController _searchController = TextEditingController();

  final bool _isSearchNotEmpty = false;
  bool isLoading = false;

  String searchText = '';
  List<Product> proList = [];

  late Future loadAll;

  Future _loadAllProData() async {
    proList = await ReadData().loadProductData();
  }

  Future<List<Product>> _loadProData(
      String text, String brand, RangeValues price, int size) async {
    isLoading = true;
    if (_isSearchNotEmpty == false) {
      proList = await ReadData()
          .searchProduct(text, brand: brand, price: price, size: size);
    } else {
      proList = await _loadAllProData();
    }
    // print("$text, $brand, $size, $price");
    isLoading = false;
    return proList;
  }

  bool isSearch(String text, String brand, int size, RangeValues price) {
    while (text.isNotEmpty &&
        brand != "" &&
        size != 0 &&
        price != const RangeValues(0.0, 10.0)) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _loadAllProData();
    _loadProData('', '', const RangeValues(0.0, 0.0), 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(!isSearchMode ? "Sản phẩm" : "Tìm kiếm"),
        forceMaterialTransparency: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<FilterVMS>(
            builder: (context, myType, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    setState(() {
                      isSearchMode = isSearch(
                          value, myType.brand, myType.size, myType.price);
                      searchText = value;

                      value.isEmpty ? !_isSearchNotEmpty : _isSearchNotEmpty;
                    });
                  },
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nhập từ khoá ở đây',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Wrap(
                      children: [
                        _searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    isSearchMode = isSearch(
                                        _searchController.text,
                                        myType.brand,
                                        myType.size,
                                        myType.price);
                                    searchText = _searchController.text;
                                  });
                                },
                                icon: const Icon(Icons.clear))
                            : const SizedBox.shrink(),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Consumer<FilterVMS>(
                                    builder: (context, myType, child) {
                                      return const FilterWidget();
                                    },
                                  );
                                }).whenComplete(() {
                              // Khi modal bottom sheet đóng, bỏ focus khỏi TextField
                              FocusScope.of(context).unfocus();
                            });
                          },
                          icon: const Icon(Icons.filter_alt_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          searchText.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      'Tất cả sản phẩm'),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      'Kết quả tìm kiếm cho \'$searchText\''),
                ),
          const Divider(
            height: 0,
          ),
          Expanded(
            child: Consumer<FilterVMS>(
              builder: (context, filter, child) {
                return FutureBuilder(
                  future: _loadProData(
                      searchText, filter.brand, filter.price, filter.size),
                  builder: (BuildContext context, snapshot) {
                    return isLoading
                        ? Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Consumer<ProductVMS>(
                              builder: (context, myType, child) {
                                return GridView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.764,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: proList.length,
                                  itemBuilder: (context, index) {
                                    return GridItem(
                                      product: proList[index],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
