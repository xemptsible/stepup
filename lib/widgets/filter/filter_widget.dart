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
                Container(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lọc theo hãng",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                BrandGrid(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lọc theo size",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          filterVMS.removeSizeFilter();
                        },
                        child: Text(
                          "Bỏ lọc",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 40, 40, 134)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedIndex = index;
                            selectedSize = 40 + index;
                            filterVMS.selectSize(selectedSize);
                          }),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                                width: 35,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: filterVMS.size - 40 == index
                                            ? 0
                                            : 1),
                                    color: filterVMS.size - 40 == index
                                        ? Color.fromARGB(255, 26, 28, 127)
                                        : Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Text(
                                  "${40 + index}",
                                  style: TextStyle(
                                      color: filterVMS.size - 40 == index
                                          ? Colors.white
                                          : Colors.black),
                                ))),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giá",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          filterVMS.removePriceFilter();
                        },
                        child: Text(
                          "Bỏ lọc",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 40, 40, 134)),
                        ),
                      ),
                    ],
                  ),
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
