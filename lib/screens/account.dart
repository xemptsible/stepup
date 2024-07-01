// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stepup/main.dart';
import 'package:stepup/screens/Info.dart';
import 'package:stepup/screens/orderTracking.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.amber,
                ),
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD3OmwXK7xXXVWJZiocRJOasPkHLK27kGGOQ&s"),
              ),

              //Text
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Loremipsum",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),

              //
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoPage(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 32,
                        ),
                      ),
                      Text(
                        "Thông tin cá nhân",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderTracking(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 32,
                        ),
                      ),
                      Text(
                        "Lịch sử đơn hàng",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.settings_outlined,
                          size: 32,
                        ),
                      ),
                      Text(
                        "Cài Đặt",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.privacy_tip_outlined,
                          size: 32,
                        ),
                      ),
                      Text(
                        "Chính sách quyền riêng",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.logout_outlined,
                          size: 32,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "Đăng xuất",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
