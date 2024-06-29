// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:stepup/screens/Account.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController _hoTenController = TextEditingController();
  TextEditingController _diaChiController = TextEditingController();
  TextEditingController _ngaySinhController = TextEditingController();
  TextEditingController _soDienThoaiController = TextEditingController();

  Widget _inputField(String label, TextEditingController _textController) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //label
          Container(
            margin: EdgeInsets.only(left: 24, bottom: 8),
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          //textfield
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Color.fromARGB(255, 110, 108, 108)),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  //Image
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 14, 6, 133)),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Input
                  SizedBox(height: 16),
                  _inputField("Họ tên:", _hoTenController),
                  SizedBox(height: 16),
                  _inputField("Địa chỉ:", _diaChiController),
                  SizedBox(height: 16),
                  _inputField("Ngày sinh:", _ngaySinhController),
                  SizedBox(height: 16),
                  _inputField("Số điện thoại:", _soDienThoaiController),
                  SizedBox(height: 24),

                  //TextButton
                  Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Lưu thay đổi",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 14, 6, 133),
                      ),
                    ),
                  )

                  //
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
