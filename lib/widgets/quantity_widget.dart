import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/providers/quantity_vm.dart';

class QuantityWidget extends StatefulWidget {
  int? quantity;
  QuantityWidget({this.quantity, super.key});

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuantityVMS>(
      builder: (context, value, child) {
        return Row(
          children: [
            InkWell(
              onTap: () => value.decrease(),
              child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 26, 28, 127)),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(value.quantity.toString())),
            InkWell(
              onTap: () => value.increase(),
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 26, 28, 127)),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.all(3),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ),
          ],
        );
      },
    );
  }
}
