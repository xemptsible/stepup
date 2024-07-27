import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/widgets/brandBar/brand_chips.dart';
import 'package:stepup/widgets/filter/price_slider.dart';

import '../../data/providers/filter_vm.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  int indexSelect = 0;
  String selectedBrand = '';
  RangeValues selectedPrice = const RangeValues(0, 0);
  int selectedSize = 0;
  bool isAscendingPrice = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterVMS>(
      builder: (context, filterVMS, child) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    "Sắp xếp và lọc",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hãng giày",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      // const BrandGrid(),
                      const BrandChipsModal(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Cỡ giày",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () => filterVMS.removeSizeFilter(),
                            child: const Text("Bỏ lọc"),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => setState(() {
                                selectedSize = 40 + index;
                                filterVMS.selectSize(selectedSize);
                              }),
                              child: Ink(
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: filterVMS.size - 40 == index
                                      ? null
                                      : Border.all(),
                                  color: filterVMS.size - 40 == index
                                      ? Theme.of(context).primaryColorLight
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    "${40 + index}",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Giá",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () => filterVMS.removePriceFilter(),
                            child: const Text("Bỏ lọc"),
                          ),
                        ],
                      ),
                      const PriceSlider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
