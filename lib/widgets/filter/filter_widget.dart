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
        return Container(
          padding: const EdgeInsets.only(bottom: 48),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sắp xếp và lọc",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hãng giày",
                    ),
                    // const BrandGrid(),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: BrandChipsModal(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Cỡ giày",
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
                            customBorder: const CircleBorder(),
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
        );
      },
    );
  }
}
