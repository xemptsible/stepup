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

  Future<String> _loadProData() async {
    proList = await ReadData().loadProductData();
    Provider.of<ProductVMS>(context, listen: false).getQuantity();
    return '';
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
                  Consumer<AccountVMS>(
                    builder: (BuildContext context, AccountVMS value,
                        Widget? child) {
                      return Consumer<ProductVMS>(
                        builder: (BuildContext context, ProductVMS valueOder,
                            Widget? child) {
                          return Row(
                            children: [
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () {
                                    List<CartItem> orderItem =
                                        Provider.of<ProductVMS>(context,
                                                listen: false)
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

                                    Provider.of<ProductVMS>(context,
                                            listen: false)
                                        .clear();
                                    dialogCustom(context);
                                  },
                                  label: Text('Thanh toán'),
                                  icon: Icon(Icons.credit_card),
                                ),
                              ),
                            ],
                          );
                        },
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
      Text(
        'Giá: ${NumberFormat('###,###.###').format(shoe.price)}đ',
      ),
      Consumer<ProductVMS>(
        builder: (BuildContext context, ProductVMS value, Widget? child) {
          return Text(
            'Số lượng: ${value.lst[index].quantity}',
          );
        },
      ),
    ],
  );
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
    String label, TextEditingController textController, TextInputType type) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4, top: 4),
    child: TextFormField(
      controller: textController,
      keyboardType: type,
      decoration: InputDecoration(
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
        return null;
      },
    ),
  );
}

// Widget _inputField(
//     String label, TextEditingController textController, TextInputType type) {
//   return SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         //label
//         Container(
//           margin: EdgeInsets.only(left: 24, bottom: 8),
//           child: Text(
//             label,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ),

//         //textfield
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 16),
//           padding: EdgeInsets.only(left: 16),
//           decoration: BoxDecoration(
//             border:
//                 Border.all(width: 1, color: Color.fromARGB(255, 110, 108, 108)),
//             borderRadius: BorderRadius.all(
//               Radius.circular(5),
//             ),
//           ),
//           child: TextFormField(
//             controller: textController,
//             keyboardType: type,
//             decoration: InputDecoration(border: InputBorder.none),
//             validator: (value) {
//               if (value == null || value.isEmpty || value == "null") {
//                 return 'Vui lòng nhập';
//               }
//               return null;
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }
