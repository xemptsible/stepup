import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/models/order_model.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/screens/mainPage/detail_history.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => OrderHistoryState();
}

class OrderHistoryState extends State<OrderHistory> {
  List<Order> orderList = [];
  bool isLoading = false;

  late Future orders;

  Future _loadOrderData() async {
    isLoading = true;
    orderList = await ReadData().loadOrderDataUser(
        Provider.of<AccountVMS>(context, listen: false).currentAcc!.Email!);
    print(orderList);
    return orderList;
  }

  @override
  void initState() {
    super.initState();
    orders = _loadOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử đơn hàng"),
      ),
      body: FutureBuilder(
        future: orders,
        builder: (context, snapshot) {
          return isLoading
              ? ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return listItem(index, orderList[index], context);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

Widget listItem(int index, Order order, BuildContext context) {
  String orderDate = DateFormat('dd/MM/yyyy').format(order.dateOrder);
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailHistory(
            order: order,
          ),
        ),
      );
    },
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.nameUser,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "Ngày Mua: $orderDate",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Tổng Giá Đơn Hàng: ${NumberFormat('###,###.###').format(order.price)}đ',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
