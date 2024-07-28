import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:stepup/data/models/order_model.dart';
import 'package:stepup/utilities/const.dart';

class DetailHistory extends StatefulWidget {
  final Order order;
  const DetailHistory({
    super.key,
    required this.order,
  });

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết đơn hàng"),
      ),
      body: ListView.builder(
        itemExtent: 130,
        itemCount: widget.order.items.length,
        itemBuilder: (context, index) {
          return listItem(widget.order, index);
        },
      ),
    );
  }
}

Widget listItem(Order order, int index) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Colors.grey.shade300),
              color: Colors.grey[100],
            ),
            child: Image.asset(
              width: 100,
              urlimg + order.items[index].product.img!,
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    overflow: TextOverflow.clip,
                    order.items[index].product.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Số lượng : ${order.items[index].quantity}",
                  ),
                  Text(
                    'Giá: ${NumberFormat('###,###.###').format(order.items[index].product.price! * order.items[index].quantity!)}đ',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
