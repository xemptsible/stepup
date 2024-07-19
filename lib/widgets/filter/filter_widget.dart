import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/widgets/filter/price_slider.dart';

import '../../data/providers/filter_vm.dart';
import '../brandBar/brand_grid.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  int _selectedIndex = 0;
  int indexSelect = 0;
  String selectedBrand = '';
  RangeValues selectedPrice = RangeValues(0, 10);
  int selectedSize = 0;
  bool isAscendingPrice = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterVMS>(
      builder: (context, filterVMS, child) {
        return Container(
          padding: EdgeInsets.only(left: 25, top: 20),
          width: MediaQuery.sizeOf(context).width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sắp xếp và lọc",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Lọc theo hãng",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                BrandGrid(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Lọc theo size",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Consumer<FilterVMS>(
                  builder: (context, myType, child) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                _selectedIndex = index;
                                selectedSize = 39 + index;
                                myType.selectSize(selectedSize);
                              }),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                    width: 35,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: _selectedIndex == index
                                                ? 0
                                                : 1),
                                        color: _selectedIndex == index
                                            ? Color.fromARGB(255, 26, 28, 127)
                                            : Colors.white,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Text(
                                      "${39 + index}",
                                      style: TextStyle(
                                          color: _selectedIndex == index
                                              ? Colors.white
                                              : Colors.black),
                                    ))),
                              ),
                            );
                          }),
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Giá",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                PriceSlider(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
