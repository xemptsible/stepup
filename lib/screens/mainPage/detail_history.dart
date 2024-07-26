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
        title: const Text("Chi Tiết Đơn Hàng"),
      ),
      body: ListView.builder(
        itemCount: widget.order.items.length,
        itemBuilder: (context, index) {
          return ListItem(widget.order, index);
        },
      ),
    );
  }
}

Widget ListItem(Order order, int index) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Image.asset(urlimg + order.items[index].product.img!),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.items[index].product.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Số Lượng : ${order.items[index].quantity}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    child: Text(
                      'Giá: ${NumberFormat('###,###.###').format(order.items[index].product.price)}đ',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
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
