import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:provider/provider.dart';
import 'package:stepup/data/providers/filter_vm.dart';
import 'package:stepup/utilities/const.dart';

import 'package:stepup/widgets/brandBar/brand_logo_selected.dart';

import '../../data/models/brand_model.dart';
import '../../data/providers/provider.dart';

class BrandGrid extends StatefulWidget {
  const BrandGrid({super.key});

  @override
  State<BrandGrid> createState() => _BrandGridState();
}

class _BrandGridState extends State<BrandGrid> {
  int _selectedIndex = 0;

  List<Brand> brandList = [];
  Future<String> loadBrandList() async {
    brandList = await ReadData().loadBrandData();
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadBrandList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadBrandList(),
        builder: (context, snapshot) {
          return SizedBox(
            height: 70,
            child: MasonryGridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brandList.length,
              itemBuilder: (context, index) {
                return Consumer<FilterVMS>(
                  builder: (context, value, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: GestureDetector(
                          onTap: () {
                            value.select(
                              brandList[index].name.toString(),
                              index,
                            );
                            _selectedIndex = value.brandSelectedIndex;
                          },
                          child: BrandLogoSelected(
                            logoImg:
                                imgLogoUrl + brandList[index].img.toString(),
                            brandName: brandList[index].name.toString(),
                            isSelected:
                                brandList[index].name.toString() == value.brand
                                    ? true
                                    : false,
                          )),
                    );
                  },
                );
              },
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            ),
          );
        });
    // return FutureBuilder(
    //     future: _loadData(),
    //     builder: (BuildContext context, snapshot) {
    //   return Container(
    //     margin: EdgeInsets.symmetric(horizontal: 20),
    //     height: 50,
    //     child: ListView.builder(
    //         scrollDirection: Axis.horizontal,
    //         itemCount: brandList.length,
    //         itemBuilder: (context, index) {
    //           return GestureDetector(
    //               onTap: () {
    //                 setState(() {
    //                   _selectedIndex = index;
    //                 });
    //               },
    //               child: BrandLogoSelected(
    //                 logoImg: imgLogoUrl + brandList[index].img.toString(),
    //                 brandName: brandList[index].name.toString(),
    //                 isSelected: _selectedIndex == index ? true : false,
    //               ));
    //         }),
    //   );
    // });
  }
}
