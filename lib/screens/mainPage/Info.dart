// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/models/account_model.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/utilities/const.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isloading = false;
  DateTime? birthDay;
  TextEditingController _hoTenController = TextEditingController();
  TextEditingController _diaChiController = TextEditingController();
  TextEditingController _ngaySinhController = TextEditingController();
  TextEditingController _soDienThoaiController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _ngaySinhController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        birthDay = pickedDate;
      });
    }
  }

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
        // print(account.BirthDay! ?? "Không có birthday");

        //check BirthDay
        if (account.BirthDay != null) {
          // String date = DateFormat('dd-MM-yyyy')
          //     .format(account.BirthDay ?? DateTime.now());
          // _ngaySinhController.text = date;
          birthDay = account.BirthDay;
          _ngaySinhController.text =
              DateFormat('dd-MM-yyyy').format(account.BirthDay!);
        } else {
          _ngaySinhController.text = '';
        }

        //check phoneNumber
        print(account.PhoneNumber.toString());
        if (account.PhoneNumber == null) {
          _soDienThoaiController.text = "";
        } else {
          _soDienThoaiController.text = account.PhoneNumber.toString();
        }
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
                  readOnly: type == TextInputType.datetime,
                  onTap: type == TextInputType.datetime
                      ? () {
                          _selectDate(context);
                        }
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //Variable
  String? filePath = "";
  String? imageUrl = "imgURL";

  //Pick image
  pickImage() async {
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    print("${file?.path}");
    setState(() {
      filePath = file?.path;
    });
    uploadImage();
  }

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  //Upload
  uploadImage() async {
    // Get a reference to storage root (đường dẫn trong firebase firestorage)
    print("Uploading Image");
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("images");

    //Create a reference for the image to be store (tạo thư mục dẫn mới)
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      //Store the file

      await referenceImageToUpload.putFile(File(filePath!));
      print("LUU THANH CONG");

      setState(() async {
        imageUrl = await referenceImageToUpload.getDownloadURL();
        Provider.of<AccountVMS>(context, listen: false).setImage(imageUrl!);
        print("Link img: " +
            Provider.of<AccountVMS>(context, listen: false).currentAcc!.Image!);
      });
    } catch (error) {
      print(error);
    }
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
                      Consumer<AccountVMS>(
                        builder: (context, value, child) {
                          return Container(
                            // clipBehavior: Clip.antiAlias,
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(top: 16),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              // color: Colors.amber,
                            ),
                            child: Image.network(
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                              value.currentAcc!.Image!,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  urlimg + "account.png",
                                  width: 150,
                                  height: 150,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pickImage();
                            });
                          },
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
                            //set current account provider
                            value.currentAcc
                                ?.setUserName(_hoTenController.text);
                            value.currentAcc?.setAdress(_diaChiController.text);
                            value.currentAcc?.setPhoneNumber(
                                int.parse((_soDienThoaiController.text)));

                            //add date
                            value.currentAcc?.setBirthDay(birthDay!);

                            //update image
                            if (imageUrl!.contains("imgURL")) {
                              // value.currentAcc!
                              //     .setImage(value.currentAcc!.Image!);
                            } else {
                              value.currentAcc?.setImage(imageUrl!);
                            }

                            //update account
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
            child: Image.asset(
                width: 150, height: 150, urlimg + "update_account.png"),
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
