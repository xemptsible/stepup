// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/favorite_vm.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/main.dart';
import 'package:stepup/screens/mainPage/Info.dart';
import 'package:stepup/screens/mainPage/order_history.dart';
import 'package:stepup/screens/mainPage/guide_page.dart';
import 'package:stepup/screens/orderTracking.dart';
import 'package:stepup/utilities/const.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AccountVMS>(
        builder: (BuildContext context, value, Widget? child) {
          return Center(
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.only(top: 100),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    fit: BoxFit.cover,
                    value.currentAcc!.Image!,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("${urlimg}account.png");
                    },
                  ),
                ),
                //Text
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    value.currentAcc!.UserName!,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
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
                        builder: (context) => const OrderHistory(),
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GuidePage()));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(
                            Icons.bookmark_border,
                            size: 32,
                          ),
                        ),
                        Text(
                          "Hướng dẫn",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    _signOut();
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
          );
        },
      ),
    );
  }
}
