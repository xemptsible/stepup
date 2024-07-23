import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/api/api.dart';
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
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  child: orderList.isEmpty
                      ? Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  urlimg + "empty_order.png",
                                  width: 150,
                                  height: 150,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Tài khoản chưa có đơn hàng",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            return ListItem(index, orderList[index], context);
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

Widget ListItem(int index, Order order, BuildContext context) {
  String orderDate = DateFormat('dd/MM/yyyy').format(order.dateOrder!);
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
    ),
  );
}
