import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stepup/utilities/const.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isSelected = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 214, 214, 214),
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(urlimg + "giayNike1.png"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      maxLines: 3,
                                      "MELO x DEXTER'S LAB MB.03 Men's Basketball Shoes ",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child: isSelected
                                    ? Icon(
                                        size: 35,
                                        Icons.favorite,
                                        color: Colors.pink,
                                      )
                                    : Icon(size: 40, Icons.favorite_border),
                                onTap: () {
                                  setState(() {
                                    isSelected = !isSelected;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Kích cỡ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 8,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Container(
                                          width: 45,
                                          margin: EdgeInsets.only(right: 20),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "${41 + index}",
                                            style: TextStyle(
                                                color: selectedIndex == index
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          decoration: BoxDecoration(
                                            border: selectedIndex == index
                                                ? null
                                                : Border.all(),
                                            shape: BoxShape.circle,
                                            color: selectedIndex == index
                                                ? Color.fromRGBO(
                                                    53, 114, 239, 1)
                                                : Colors.white,
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số lượng",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Expanded(
                                  child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromARGB(255, 26, 28, 127)),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      )),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text("1")),
                                  Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromARGB(255, 26, 28, 127)),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      padding: EdgeInsets.all(3),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ],
                              )),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 26, 28, 127)),
                        onPressed: () {},
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Thêm vào giỏ hàng",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Thông tin sản phẩm",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                style: TextStyle(color: Colors.grey),
                                "Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở  Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở  Nike Air Max 270 ‘White Black’ sử dụng nhựa tổng hợp nhẹ và mềm ở phía trên. Điều này có các lỗ để đảm bảo không khí lưu thông đến chân, ngay cả trong những ngày nắng nóng."),
                          ),
                        )),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  textAlign: TextAlign.start, "Có thắc mắc ?")),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Container(
                                alignment: Alignment.center,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {},
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.contact_support_sharp,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            "Liên hệ hỗ trợ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ],
                                      )),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
