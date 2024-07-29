// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stepup/app.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/order_model.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/utilities/const.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  DateTime nowDate = DateTime.now();
  final TextEditingController _hoTenController = TextEditingController();
  final TextEditingController _diaChiController = TextEditingController();
  final TextEditingController _soDienThoaiController = TextEditingController();

  List<Product> proList = [];

  final _formKey = GlobalKey<FormState>();

  Future _loadProData() async {
    proList = await ReadData().loadProductData();
    if (mounted) {
      await Provider.of<ProductVMS>(context, listen: false).getQuantity();
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProData();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final accountVMS = Provider.of<AccountVMS>(context, listen: false);
        final account = accountVMS.currentAcc;
        if (account != null) {
          _hoTenController.text = account.UserName ?? '';
          _diaChiController.text = account.Address ?? '';

          if (account.PhoneNumber.toString().contains("null")) {
            _soDienThoaiController.text = "";
          } else {
            _soDienThoaiController.text = account.PhoneNumber.toString();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thanh toán"),
        forceMaterialTransparency: true,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _inputField(
                      "Tên khách hàng", _hoTenController, TextInputType.text),
                  _inputField("Địa chỉ", _diaChiController, TextInputType.text),
                  _inputField("Số điện thoại", _soDienThoaiController,
                      TextInputType.number),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Consumer<ProductVMS>(
                      builder: (context, value, child) {
                        return Text(
                          "Số lượng giày: ${value.quatity.toString()}",
                          style: TextStyle(fontSize: 18),
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  Consumer<ProductVMS>(
                    builder: (context, value, child) {
                      return Expanded(
                        child: FutureBuilder(
                          future: _loadProData(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: value.lst.length,
                              itemBuilder: (context, index) {
                                return itemList(
                                    context, value.lst[index].product, index);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(236, 236, 243, 0.612),
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black26),
                ),
              ),
              child: Column(
                children: [
                  Consumer<ProductVMS>(
                    builder: (BuildContext context, ProductVMS value,
                        Widget? child) {
                      return Text(
                        "Tổng đơn hàng: ${NumberFormat('###,###.###').format(value.total)}đ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  Consumer2<AccountVMS, ProductVMS>(
                    builder: (context, account, checkout, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  List<CartItem> orderItem =
                                      Provider.of<ProductVMS>(context,
                                              listen: false)
                                          .lst;

                                  thanhToan() {
                                    Navigator.pop(context);

                                    Order order = Order(
                                        nameUser: account.currentAcc!.UserName!,
                                        items: orderItem,
                                        email: account.currentAcc!.Email!,
                                        dateOrder: nowDate,
                                        price: checkout.total);
                                    print(order.toJson());

                                    ApiService apiService = ApiService();
                                    apiService.postOrder(order);

                                    Provider.of<ProductVMS>(context,
                                            listen: false)
                                        .clear();
                                    dialogThanhToan(context);
                                  }

                                  if (orderItem.isNotEmpty) {
                                    showModalBottomSheet<void>(
                                      showDragHandle: true,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              'Chọn phương thức thanh toán',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Divider(),
                                            ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              children: [
                                                InkWell(
                                                  onTap: () => thanhToan(),
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 8),
                                                    leading: Image.asset(
                                                      width: 56,
                                                      '${urlimg}momo.png',
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Icon(
                                                              Icons
                                                                  .payment_outlined,
                                                              size: 56),
                                                    ),
                                                    title: Text('Momo'),
                                                    trailing: Icon(
                                                        Icons.arrow_forward),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => thanhToan(),
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 8),
                                                    leading: Image.asset(
                                                      width: 56,
                                                      '${urlimg}vnpay.png',
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Icon(
                                                              Icons
                                                                  .payment_outlined,
                                                              size: 56),
                                                    ),
                                                    title: Text('VNPAY'),
                                                    trailing: Icon(
                                                        Icons.arrow_forward),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => thanhToan(),
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 8),
                                                    leading: Image.asset(
                                                      width: 56,
                                                      '${urlimg}zalopay.png',
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Icon(
                                                              Icons
                                                                  .payment_outlined,
                                                              size: 56),
                                                    ),
                                                    title: Text('ZaloPay'),
                                                    trailing: Icon(
                                                        Icons.arrow_forward),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 0,
                                                ),
                                                InkWell(
                                                  onTap: () => thanhToan(),
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 8),
                                                    leading: Icon(
                                                      Icons.payment_outlined,
                                                      size: 56,
                                                    ),
                                                    title: Text('Ngân hàng'),
                                                    trailing: Icon(
                                                        Icons.arrow_forward),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    dialogGioHangRong(context);
                                  }
                                }
                              },
                              label: Text('Thanh toán'),
                              icon: Icon(Icons.credit_card),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget itemList(BuildContext context, Product shoe, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Card.outlined(
      elevation: 4,
      shadowColor: Colors.black,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
                border: Border.all(
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Colors.grey.shade300),
              ),
              child: Image.asset(
                width: 100,
                height: 100,
                urlimg + shoe.img.toString(),
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: item(shoe, index),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget item(Product shoe, int index) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        shoe.name!,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Text(
        "Hãng giày: ${shoe.brand!}",
      ),
      Consumer<ProductVMS>(
        builder: (BuildContext context, ProductVMS value, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${NumberFormat('###,###.###').format(shoe.price)}đ - Tổng: ${NumberFormat('###,###.###').format(shoe.price! * value.lst[index].quantity!)}đ',
              ),
              Text(
                'Số lượng: ${value.lst[index].quantity}',
              ),
            ],
          );
        },
      ),
    ],
  );
}

dialogThanhToan(BuildContext context) {
  Dialog errorDialog = Dialog(
//this right here
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Thanh toán thành công",
            style: TextStyle(fontSize: 18),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Icon(
              Icons.check_circle_outline_outlined,
              size: 100,
              color: Colors.green,
            ),
          ),
          Consumer<ProductVMS>(
            builder: (BuildContext context, ProductVMS value, Widget? child) {
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const App(),
                            ),
                            ModalRoute.withName('/homePage'),
                          );
                          value.clear();
                        },
                        child: Text('Trở về'),
                      ),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}

dialogGioHangRong(BuildContext context) {
  Dialog errorDialog = Dialog(
//this right here
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Không có gì để thanh toán!",
            style: TextStyle(fontSize: 18),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Icon(
              Icons.warning_amber_outlined,
              size: 100,
              color: Colors.red,
            ),
          ),
          Consumer<ProductVMS>(
            builder: (BuildContext context, ProductVMS value, Widget? child) {
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const App(),
                            ),
                            ModalRoute.withName('/homePage'),
                          );
                        },
                        child: Text('Trở về'),
                      ),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}

Widget _inputField(
    String label, TextEditingController textController, TextInputType type) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4, top: 4),
    child: TextFormField(
      controller: textController,
      keyboardType: type,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
          prefix: label.toLowerCase().contains('số điện thoại')
              ? Text('+84 ')
              : null,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          label: Text(label),
          helperText: " "),
      readOnly: type == TextInputType.datetime,
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
}
