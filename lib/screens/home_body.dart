import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/providers/brand_vm.dart';
import '../widgets/brandBar/brand_select_bar.dart';
import '../widgets/filtedProducts/brand_selected_product.dart';
import '../widgets/filtedProducts/product_list.dart';

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
    return ChangeNotifierProvider<BrandsVM>(
      create: (context) => BrandsVM(),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: Column(
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
                          "StepUP",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 24),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Icon(
                                Icons.search,
                                size:
                                    MediaQuery.of(context).size.height * 0.033,
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.notifications,
                                size:
                                    MediaQuery.of(context).size.height * 0.033,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              BrandSelectPro(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Phổ biến",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/productsPage");
                      },
                      child: Text("see all")),
                ],
              ),
              BrandBar(),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                color: Colors.red,
                child: ProductList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
