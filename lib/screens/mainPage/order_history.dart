import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/order_model.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/screens/mainPage/detail_history.dart';
import 'package:stepup/utilities/const.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => OrderHistoryState();
}

class OrderHistoryState extends State<OrderHistory> {
  List<Order> orderList = [];

  bool isLoading = false;

  late Future bill;

  Future<String> _loadOrderData() async {
    isLoading = true;
    orderList = await ReadData().loadOrderDataUser(
        Provider.of<AccountVMS>(context, listen: false).currentAcc!.Email!);
    // orderList = await ReadData().loadOrderData();
    isLoading = false;

    return '';
  }

  @override
  void initState() {
    super.initState();
    bill = _loadOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử đơn hàng"),
      ),
      body: FutureBuilder(
        future: bill,
        builder: (context, snapshot) {
          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  child: orderList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "${urlimg}empty_order.png",
                                width: 150,
                                height: 150,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Tài khoản chưa có đơn hàng",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            return billItem(index, orderList[index], context);
                          },
                        ),
                );
        },
      ),
    );
  }
}

// if (orderList.isEmpty) {
//             return Container(
//               child: Text("không có data"),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: orderList.length,
//               itemBuilder: (context, index) {
//                 return ListItem(index, orderList[index], context);
//               },
//             );
//           }

Widget billItem(int index, Order order, BuildContext context) {
  String orderDate = DateFormat('dd/MM/yyyy').format(order.dateOrder);
  return Card.outlined(
    clipBehavior: Clip.antiAlias,
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    surfaceTintColor: Colors.white,
    child: InkWell(
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.nameUser,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderDate,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Tổng giá: ${NumberFormat('###,###.###').format(order.price)}đ',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
