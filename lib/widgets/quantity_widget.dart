import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/providers/quantity_vm.dart';

class QuantityWidget extends StatefulWidget {
  final Product shoe;
  final int index;
  QuantityWidget({super.key, required this.shoe, required this.index});

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  void initState() {
    // TODO: implement initState
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
              child: Text(value.lst[widget.index].quantity.toString()),
            ),
            InkWell(
              onTap: () {
                value.increaseCart(value.lst[widget.index]);
              },
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
