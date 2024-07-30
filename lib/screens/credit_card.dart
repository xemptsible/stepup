import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:stepup/app.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/models/cart_item.dart';
import 'package:stepup/data/models/order_model.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/product_vm.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<StatefulWidget> createState() => _CCState();
}

class _CCState extends State<CreditCardPage> {
  DateTime nowDate = DateTime.now();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading:
          //     IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: false,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {}),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CreditCardForm(
                    formKey: _formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    inputConfiguration: const InputConfiguration(
                      cardNumberDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Số Thẻ',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Ngày Hết Hạn',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Chủ Thẻ',
                      ),
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Consumer2<AccountVMS, ProductVMS>(
                            builder: (context, account, checkout, child) {
                              return FilledButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    List<CartItem> orderItem =
                                        Provider.of<ProductVMS>(context,
                                                listen: false)
                                            .lst;

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

                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    dialogThanhToan(context);
                                  }
                                },
                                child: const Text('Xác nhận'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
    });
  }

  dialogThanhToan(BuildContext context) {
    Dialog errorDialog = Dialog(
//this right here
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Thanh toán thành công",
              style: TextStyle(fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: const Icon(
                Icons.check_circle_outline_outlined,
                size: 100,
                color: Colors.green,
              ),
            ),
            Consumer<ProductVMS>(
              builder: (BuildContext context, ProductVMS value, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
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
                              child: const Text('Trở về'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.popAndPushNamed(context, '/history');
                                value.clear();
                              },
                              child: const Text('Xem đơn hàng'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
