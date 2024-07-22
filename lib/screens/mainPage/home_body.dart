import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/screens/mainPage/search_page.dart';
import '../../data/providers/brand_vm.dart';
import '../../data/providers/product_vm.dart';
import '../../widgets/brandBar/brand_select_bar.dart';
import '../../widgets/filtedProducts/brand_selected_product.dart';
import '../../widgets/filtedProducts/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool selected = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StepUP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ChangeNotifierProvider<BrandsVM>(
        create: (context) => BrandsVM(),
        child: ChangeNotifierProvider<ProductVMS>(
          create: (context) => ProductVMS(),
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const BrandSelectPro(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Phổ biến",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage(
                                          isSearch: false,
                                        )),
                              );
                            },
                            child: const Text("Xem tất cả")),
                      ],
                    ),
                  ),
                  const BrandBar(),
                  const ProductList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
