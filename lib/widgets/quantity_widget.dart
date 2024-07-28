import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/product_vm.dart';

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
            IconButton.filled(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                setState(() {
                  value.decreaseCart(value.lst[widget.index]);
                });
              },
              icon: const Icon(Icons.remove),
            ),
            SizedBox(
              width: 40,
              // margin: const EdgeInsets.symmetric(horizontal: 10),
              // child: Text(value.lst[widget.index].quantity.toString()),
              child: Text(
                widget.quantity.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton.filled(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                setState(() {
                  value.increaseCart(value.lst[widget.index]);
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        );
      },
    );
  }
}
