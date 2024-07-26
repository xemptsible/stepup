import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:stepup/data/providers/filter_vm.dart';
import 'package:stepup/utilities/const.dart';

import '../../data/models/brand_model.dart';
import '../../data/providers/brand_vm.dart';
import '../../data/providers/provider.dart';

class BrandChipsBar extends StatefulWidget {
  const BrandChipsBar({super.key});

  @override
  State<StatefulWidget> createState() => _BrandState();
}

class _BrandState extends State<BrandChipsBar> {
  int? _selectedIndex = 0;

  late Future brands;

  List<Brand> brandList = [];
  Future<String> loadBrandList() async {
    brandList = await ReadData().loadBrandData();
    return '';
  }

  @override
  void initState() {
    super.initState();
    brands = loadBrandList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: brands,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Consumer<BrandsVM>(
            builder: (context, brand, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  children: List.generate(
                    brandList.length,
                    (brandIndex) {
                      return ChoiceChip(
                        showCheckmark: false,
                        avatar: Image.asset(
                          imgLogoUrl + brandList[brandIndex].img.toString(),
                          fit: BoxFit.contain,
                          color: Colors.black,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.category);
                          },
                        ),
                        label: Text(brandList[brandIndex].name.toString()),
                        selected: _selectedIndex == brandIndex,
                        onSelected: (isSelected) {
                          setState(
                            () {
                              _selectedIndex = isSelected ? brandIndex : 0;
                              brand.select(
                                brandIndex,
                                brandList[brandIndex].name.toString(),
                              );
                              // print(_selectedIndex);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BrandChipsModal extends StatefulWidget {
  const BrandChipsModal({super.key});

  @override
  State<StatefulWidget> createState() => _BrandModalState();
}

class _BrandModalState extends State<BrandChipsModal> {
  int? _selectedIndex = 0;

  late Future brands;

  List<Brand> brandList = [];
  Future<String> loadBrandList() async {
    brandList = await ReadData().loadBrandData();
    return '';
  }

  @override
  void initState() {
    super.initState();
    brands = loadBrandList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: brands,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Consumer<FilterVMS>(
            builder: (context, brand, child) {
              return Wrap(
                spacing: 8,
                children: List.generate(
                  brandList.length,
                  (brandIndex) {
                    return ChoiceChip(
                      showCheckmark: false,
                      avatar: Image.asset(
                        imgLogoUrl + brandList[brandIndex].img.toString(),
                        fit: BoxFit.contain,
                        color: Colors.black,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.category);
                        },
                      ),
                      label: Text(brandList[brandIndex].name.toString()),
                      selected: _selectedIndex == brandIndex,
                      onSelected: (isSelected) {
                        setState(
                          () {
                            _selectedIndex = isSelected ? brandIndex : 0;
                            brand.select(
                              brandList[brandIndex].name.toString(),
                              brandIndex,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
