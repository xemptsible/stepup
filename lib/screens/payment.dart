// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stepup/utilities/const.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    String dropdownValue = list.first;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Text(
                    "Thanh Toán",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //item 1
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Image.asset(
                                urlimg + "anh1.png",
                                height: 100,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.image),
                              ),
                            ),
                            Text(
                              "MoMo",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 24),
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.arrow_forward),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    //item2

                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Image.asset(
                                urlimg + "anh2.png",
                                height: 100,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.image),
                              ),
                            ),
                            Text(
                              "NVPay",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                margin: EdgeInsets.only(right: 24),
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.arrow_forward),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    //item3
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Image.asset(
                                urlimg + "anh3.png",
                                height: 100,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.image),
                              ),
                            ),
                            Text(
                              "ZaloPay",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                margin: EdgeInsets.only(right: 24),
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      height: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 204, 202, 199),
                      ),
                    ),

                    //Text
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Hoặc trả bằng thẻ ngân hàng",
                        style: TextStyle(
                          color: Color.fromARGB(255, 43, 42, 40),
                          fontSize: 16,
                        ),
                      ),
                    ),

                    //dropdown

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1),
                      ),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                      //
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
