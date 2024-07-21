// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../test/model/shoe.dart';
import 'orderTrackingScreen/DaHuy.dart';
import 'orderTrackingScreen/DaGiao.dart';
import 'orderTrackingScreen/DangGiao.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  Shoe newShoe = Shoe(
    name: "Giay",
    price: 10000,
    brand: "brand",
    size: 30,
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: [
                Text(
                  "Theo dõi đơn hàng",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            tabs: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Đã giao",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Đang giao",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Đã hủy",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DagiaoPage(),
            DanggiaoPage(),
            DaHuyPage(),
          ],
        ),
      ),
    );
  }
}




// ProductListItem(
//               thumbnail: Container(
//                 color: Colors.red,
//               ),
//               shoe: newShoe,
//             ).ListItem(),
