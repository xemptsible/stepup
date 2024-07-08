import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceSlider extends StatefulWidget {
  const PriceSlider({super.key});

  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  RangeValues values = RangeValues(10000, 5000000);
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
        values: values,
        divisions: 20,
        labels: RangeLabels(
            values.start.round().toString(), values.end.round().toString()),
        min: 10000,
        max: 10000000,
        onChanged: (values) => setState(() {
              this.values = values;
            }));
  }
}
