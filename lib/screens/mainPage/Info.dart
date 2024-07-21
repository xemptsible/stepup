// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/models/account_model.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/provider.dart';

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
  late Account? currentAcc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final accountVMS = Provider.of<AccountVMS>(context, listen: false);
      final account = accountVMS.currentAcc;
      if (account != null) {
        _hoTenController.text = account.UserName ?? '';
        _diaChiController.text = account.Address ?? '';
        _ngaySinhController.text =
            account.BirthDay != null ? account.BirthDay.toString() : '';
        _soDienThoaiController.text = account.PhoneNumber ?? '';
      }
    });
  }

  Widget _inputField(
      String label, TextEditingController _textController, TextInputType type) {
    return Consumer<AccountVMS>(
      builder: (BuildContext context, AccountVMS value, Widget? child) {
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
                  controller: _textController,
                  keyboardType: type,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        );
      },
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
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  //Image
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Colors.amber,
                        ),
                        child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD3OmwXK7xXXVWJZiocRJOasPkHLK27kGGOQ&s"),
                      ),
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

                  //Input
                  SizedBox(height: 16),
                  _inputField("Họ tên:", _hoTenController, TextInputType.text),
                  SizedBox(height: 16),
                  _inputField(
                      "Địa chỉ:", _diaChiController, TextInputType.text),
                  SizedBox(height: 16),
                  _inputField("Ngày sinh:", _ngaySinhController,
                      TextInputType.datetime),
                  SizedBox(height: 16),
                  _inputField("Số điện thoại:", _soDienThoaiController,
                      TextInputType.phone),
                  SizedBox(height: 24),

                  //TextButton
                  Consumer<AccountVMS>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: TextButton(
                          onPressed: () {
                            value.currentAcc
                                ?.setUserName(_hoTenController.text);
                            value.currentAcc?.setAdress(_diaChiController.text);
                            value.currentAcc
                                ?.setPhoneNumber(_soDienThoaiController.text);

                            value.updateCurrentAcc();
                            DiaglogCustom(context);
                          },
                          child: Text(
                            "Lưu thay đổi",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 14, 6, 133),
                          ),
                        ),
                      );
                    },
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

void DiaglogCustom(BuildContext context) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: Text(
              "Sửa Thông Tin Thành Công",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Image.network(
                width: 150,
                height: 150,
                "https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/512x512/plain/clipboard_check_edit.png"),
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width * 0.7,
                height: MediaQuery.sizeOf(context).height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 32, 74, 150)),
                child: Text(
                  'Trở về',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ))
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}
