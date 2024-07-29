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

  final _formKey = GlobalKey<FormState>();

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
        // print(account.PhoneNumber.toString());
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
          child: TextFormField(
            controller: textController,
            keyboardType: type,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              prefixText:
                  label.toLowerCase() == 'số điện thoại' ? '+84 ' : null,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              label: Text(label),
            ),
            readOnly: type == TextInputType.datetime,
            onTap: type == TextInputType.datetime
                ? () => _selectDate(context)
                : null,
            validator: (value) {
              if (value == null || value.isEmpty || value == "null") {
                return 'Vui lòng nhập';
              }
              if (label.toLowerCase() == 'số điện thoại') {
                if (value.length > 10 || value.length < 10) {
                  return 'Vui lòng nhập số điện thoại hợp lệ';
                }
              }
              return null;
            },
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
        if (mounted) {
          Provider.of<AccountVMS>(context, listen: false)
              .currentAcc!
              .setImage(imageUrl!);
          setState(() {});
        }
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image
            Consumer<AccountVMS>(
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.black26),
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(value.currentAcc!.Image!),
                        onBackgroundImageError: (exception, stackTrace) {
                          AssetImage("${urlimg}account.png");
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton.filled(
                            onPressed: () {
                              setState(() {
                                pickImage();
                              });
                            },
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   clipBehavior: Clip.antiAlias,
                    //   width: 150,
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     // color: Colors.indigoAccent
                    //   ),
                    //   child: Image.network(
                    //     fit: BoxFit.contain,
                    //     // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD3OmwXK7xXXVWJZiocRJOasPkHLK27kGGOQ&s",
                    //     value.currentAcc!.Image!,
                    //     errorBuilder: (context, error, stackTrace) {
                    //       return Image.asset(
                    //         "${urlimg}account.png",
                    //         errorBuilder: (context, error, stackTrace) {
                    //           return SizedBox(
                    //             height: 150,
                    //             child: Icon(
                    //               Icons.image_not_supported_outlined,
                    //               size: 100,
                    //             ),
                    //           );
                    //         },
                    //       );
                    //     },
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 105,
                    //   left: 105,
                    //   child: IconButton.filled(
                    //     onPressed: () {
                    //       setState(() {
                    //         pickImage();
                    //       });
                    //     },
                    //     icon: Icon(
                    //       Icons.edit_outlined,
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      TextInputType.datetime,
                    ),
                    _inputField(
                      'Số điện thoại',
                      _soDienThoaiController,
                      TextInputType.phone,
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
                                    if (_formKey.currentState!.validate()) {
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
                                      dialogSuaThongTin(context);
                                    }
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
            ),
          ],
        ),
      ),
    );
  }
}

void dialogSuaThongTin(BuildContext context) {
  Dialog editDialog = Dialog(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text(
              'Sửa thông tin thành công',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => editDialog);
}
