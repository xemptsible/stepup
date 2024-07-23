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
import 'package:stepup/test/model/shoe.dart';
import 'package:stepup/utilities/const.dart';
import 'package:stepup/widgets/cartList/cart_list.dart';
import 'package:stepup/widgets/quantity_widget.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  DateTime nowDate = DateTime.now();
  TextEditingController _hoTenController = TextEditingController();
  TextEditingController _diaChiController = TextEditingController();
  TextEditingController _soDienThoaiController = TextEditingController();
  List<Product> proList = [];
  Future<String> _loadProData() async {
    proList = await ReadData().loadProductData();
    Provider.of<ProductVMS>(context, listen: false).getQuantity();
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thanh Toán"),
      ),
      body: Container(
        child: Column(
          children: [
            _inputField("Tên Khách Hàng", _hoTenController, TextInputType.text),
            _inputField("Địa chỉ", _diaChiController, TextInputType.text),
            _inputField(
                "Số điện thoại", _soDienThoaiController, TextInputType.number),
            Consumer<ProductVMS>(builder: (context, value, child) {
              return Container(
                  margin: EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Số lượng giày: ${value.quatity.toString()}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ));
            }),
            Consumer<ProductVMS>(
              builder: (context, value, child) {
                return Expanded(
                  child: Container(
                    // margin: EdgeInsets.only(top: 16),
                    // color: Colors.red,
                    child: FutureBuilder(
                      future: _loadProData(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: value.lst.length,
                            itemBuilder: (context, index) {
                              return itemList(
                                  context, value.lst[index].product, index);
                            });
                      },
                    ),
                  ),
                );
              },
            ),
            Divider(),
            Consumer<ProductVMS>(
              builder: (BuildContext context, ProductVMS value, Widget? child) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Tổng Đơn Hàng: ${NumberFormat('###,###.###').format(value.total)}đ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                );
              },
            ),
            Consumer<AccountVMS>(
              builder: (BuildContext context, AccountVMS value, Widget? child) {
                return Container(
                    margin: EdgeInsets.only(bottom: 30),
                    // color: Colors.amber,
                    child: Consumer<ProductVMS>(
                      builder: (BuildContext context, ProductVMS valueOder,
                          Widget? child) {
                        return InkWell(
                          onTap: () {
                            List<CartItem> orderItem =
                                Provider.of<ProductVMS>(context, listen: false)
                                    .lst;
                            Order order = Order(
                                nameUser: value.currentAcc!.UserName!,
                                items: orderItem,
                                email: value.currentAcc!.Email!,
                                dateOrder: nowDate,
                                price: valueOder.total);
                            print(order.toJson());

                            ApiService apiService = ApiService();
                            apiService.postOrder(order);

                            Provider.of<ProductVMS>(context, listen: false)
                                .clear();
                            DiaglogCustom(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 26, 28, 127)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.credit_card_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Thanh toán",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget itemList(BuildContext context, Product shoe, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SizedBox(
      height: 140,
      child: Card.outlined(
        elevation: 3,
        shadowColor: Colors.black,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                // color: Color.fromARGB(255, 234, 233, 233),
                width: 120,
                child: Image.asset(
                  width: 100,
                  urlimg + shoe.img.toString(),
                  fit: BoxFit.cover,
                ),
                // child: thumbnail,
              ),
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.amber,
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.135,
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 10),
                          child: item(shoe, index),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget item(Product shoe, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Text(
          "${shoe.name!}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      Text(
        "Hãng Giày: ${shoe.brand!}",
      ),
      Text(
        'Giá: ${NumberFormat('###,###.###').format(shoe.price)}đ',
      ),
      Consumer<ProductVMS>(
        builder: (BuildContext context, ProductVMS value, Widget? child) {
          return Text(
            'Số Lượng: ${value.lst[index].quantity}',
          );
        },
      ),
    ],
  );
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
              "Thanh Toán Thành Công",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Image.network(
                width: 150,
                height: 150,
                "https://cdn4.iconfinder.com/data/icons/e-commerce-and-shopping-3/500/cart-checked-512.png"),
          ),
          Consumer<ProductVMS>(
            builder: (BuildContext context, ProductVMS value, Widget? child) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => App(),
                      ),
                    );
                    value.clear();
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
                  ));
            },
          )
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}

Widget _inputField(
    String label, TextEditingController _textController, TextInputType type) {
  return SingleChildScrollView(
    child: Container(
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
            child: TextFormField(
              controller: _textController,
              keyboardType: type,
              decoration: InputDecoration(border: InputBorder.none),
              validator: (value) {
                if (value == null || value.isEmpty || value == "null") {
                  return 'Vui lòng nhập';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    ),
  );
}
