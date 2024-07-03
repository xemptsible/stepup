import 'package:flutter/material.dart';
import 'package:stepup/test/model/shoe.dart';
import 'package:stepup/utilities/const.dart';

class ProductListItem extends StatelessWidget {
  final int page;
  final Widget thumbnail;
  final Shoe shoe;

  const ProductListItem({
    super.key,
    required this.thumbnail,
    required this.shoe,
    required this.page,
  });

  Widget ListItemDonHang(BuildContext context, String text) {
    return SizedBox(
      height: 150,
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: Image.asset(urlimg + "giayNike1.png"),
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
                        height: MediaQuery.sizeOf(context).height * 0.12,
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Shoe(
                            name: shoe.name,
                            brand: shoe.brand,
                            // discount: shoe.discount,
                            price: shoe.price,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        // color: Colors.amberAccent,
                        child: Stack(
                          children: [
                            Positioned(
                              right: 10,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 57, 82, 196)),
                                // color: Color.fromARGB(255, 57, 82, 196),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    text,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: () {
      if (page == 1)
        return ListItemDonHang(context, "Xem sản phẩm");
      else if (page == 2)
        return ListItemDonHang(context, "Xem chi tiết");
      else
        return ListItemDonHang(context, "Hủy bỏ");
    }());
  }
}
