import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/providers/quantity_vm.dart';

class QuantityWidget extends StatefulWidget {
  final Product shoe;
  final int index;
  final int quantity;
  const QuantityWidget(
      {super.key,
      required this.shoe,
      required this.index,
      required this.quantity});

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductVMS>(
      builder: (BuildContext context, ProductVMS value, Widget? child) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  value.decreaseCart(value.lst[widget.index]);
                });
              },
              child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 26, 28, 127)),

                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              // child: Text(value.lst[widget.index].quantity.toString()),
              child: Text(widget.quantity.toString()),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  value.increaseCart(value.lst[widget.index]);
                });
              },
              child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 26, 28, 127)),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(3),
                  child: const Icon(
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
