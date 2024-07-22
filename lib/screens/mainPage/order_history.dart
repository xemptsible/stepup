import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/models/order_model.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => OrderHistoryState();
}

class OrderHistoryState extends State<OrderHistory> {
  List<Order> orderList = [];
  bool isLoading = false;
  Future<String> _loadOrderData() async {
    orderList = await ReadData().loadOrderDataUser(
        Provider.of<AccountVMS>(context, listen: false).currentAcc!.Email!);

    isLoading = true;

    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch Sử Đơn Hàng"),
      ),
      body: FutureBuilder(
        future: _loadOrderData(),
        builder: (context, snapshot) {
          return isLoading
              ? ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return ListItem(index, orderList[index]);
                  },
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Widget ListItem(int index, Order order) {
  String orderDate = DateFormat('dd/MM/yyyy').format(order.dateOrder!);
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 90,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.nameUser!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            "Ngày Mua: " + orderDate,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Container(
            child: Text(
              'Tổng Giá Đơn Hàng: ${NumberFormat('###,###.###').format(order.price)}đ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
