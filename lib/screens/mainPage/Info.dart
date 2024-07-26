// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/models/account_model.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/utilities/const.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isloading = false;
  DateTime? birthDay;
  final TextEditingController _hoTenController = TextEditingController();
  final TextEditingController _diaChiController = TextEditingController();
  final TextEditingController _ngaySinhController = TextEditingController();
  final TextEditingController _soDienThoaiController = TextEditingController();

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
      String label, TextEditingController textController, TextInputType type) {
    return Consumer<AccountVMS>(
      builder: (BuildContext context, AccountVMS value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextField(
            controller: textController,
            keyboardType: type,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              label: Text(label),
            ),
            readOnly: type == TextInputType.datetime,
            onTap: type == TextInputType.datetime
                ? () => _selectDate(context)
                : null,
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
        print(imageUrl);
        Provider.of<AccountVMS>(context, listen: false)
            .currentAcc!
            .setImage(imageUrl!);
        print(
            "Link img: ${Provider.of<AccountVMS>(context, listen: false).currentAcc!.Image!}");
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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                //Image
                Consumer<AccountVMS>(
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            width: 150,
                            // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD3OmwXK7xXXVWJZiocRJOasPkHLK27kGGOQ&s",
                            value.currentAcc!.Image!,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  width: 150, "${urlimg}account.png");
                            },
                          ),
                        ),
                        Positioned(
                          top: 105,
                          left: 105,
                          child: IconButton.filled(
                            onPressed: () {
                              setState(() {
                                pickImage();
                              });
                            },
                            icon: Icon(
                              Icons.edit_outlined,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      //Input
                      _inputField(
                        'Họ tên',
                        _hoTenController,
                        TextInputType.text,
                      ),
                      _inputField(
                        'Địa chỉ',
                        _diaChiController,
                        TextInputType.text,
                      ),
                      _inputField(
                        'Ngày sinh',
                        _ngaySinhController,
                        TextInputType.text,
                      ),
                      _inputField(
                        'Số điện thoại',
                        _soDienThoaiController,
                        TextInputType.text,
                      ),

                      //TextButton
                      Consumer<AccountVMS>(
                        builder: (BuildContext context, value, Widget? child) {
                          return Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {
                                      //set current account provider
                                      value.currentAcc
                                          ?.setUserName(_hoTenController.text);
                                      value.currentAcc
                                          ?.setAdress(_diaChiController.text);
                                      value.currentAcc?.setPhoneNumber(
                                          int.parse(
                                              _soDienThoaiController.text));

                                      //add date
                                      value.currentAcc?.setBirthDay(birthDay!);

                                      //update account
                                      value.updateCurrentAcc();

                                      dialogCustom(context);
                                    },
                                    label: const Text('Lưu thay đổi'),
                                    icon: const Icon(Icons.save),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void dialogCustom(BuildContext context) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: SizedBox(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: Text(
              "Sửa thông tin thành công",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Image.asset(
                width: 150, height: 150, "${urlimg}update_account.png"),
          ),
          InkWell(
              onTap: () {
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
