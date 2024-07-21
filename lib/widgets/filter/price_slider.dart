import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/providers/filter_vm.dart';
import 'package:stepup/data/providers/price_vm.dart';

class PriceSlider extends StatefulWidget {
  const PriceSlider({super.key});

  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  RangeValues values = RangeValues(10000, 5000000);
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterVMS>(
      builder: (context, myType, child) {
        values = myType.price ?? values;
        return RangeSlider(
          values: values,
          divisions: 20,
          labels: RangeLabels(
              "${NumberFormat("###,###.###").format(values.start.round())}đ",
              "${NumberFormat("###,###.###").format(values.end.round())}đ"),
          min: 0,
          max: 10000000,
          onChanged: (values) => setState(() {
            this.values = values;
            myType.selectPrice(values);
          }),
        );
      },
    );
  }
}
