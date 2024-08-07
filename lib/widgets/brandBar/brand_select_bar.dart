import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:stepup/utilities/const.dart';
import 'package:stepup/widgets/brandBar/brand_logo_selected.dart';

import '../../data/models/brand_model.dart';
import '../../data/providers/brand_vm.dart';
import '../../data/providers/provider.dart';

class BrandBar extends StatefulWidget {
  const BrandBar({super.key});

  @override
  State<BrandBar> createState() => _BrandBarState();
}

class _BrandBarState extends State<BrandBar> {
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
            height: 35,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: brandList.length,
                itemBuilder: (context, index) {
                  return Consumer<BrandsVM>(
                    builder: (context, value, child) {
                      return GestureDetector(
                          onTap: () {
                            value.select(
                                index, brandList[index].name.toString());
                            _selectedIndex = value.selectedIndex;
                          },
                          child: BrandLogoSelected(
                            logoImg:
                                imgLogoUrl + brandList[index].img.toString(),
                            brandName: brandList[index].name.toString(),
                            isSelected: _selectedIndex == index ? true : false,
                          ));
                    },
                  );
                }),
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
