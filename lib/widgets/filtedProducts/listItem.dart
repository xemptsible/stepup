import 'package:flutter/material.dart';
import 'package:stepup/data/models/shoe.dart';
import 'package:stepup/utilities/const.dart';
import 'package:stepup/widgets/cartList/cart_item.dart';

class ProductListItem extends StatefulWidget {
  final int page;
  // final Widget thumbnail;
  final ShoeAPI shoe;

  const ProductListItem({
    super.key,
    // required this.thumbnail,
    required this.shoe,
    required this.page,
  });

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
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
                child: Image.network(widget.shoe.Image),
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
                            name: widget.shoe.NameShoe,
                            brand: widget.shoe.Brand,
                            // discount: shoe.discount,
                            price: widget.shoe.Price.toDouble(),
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
      if (widget.page == 1)
        return ListItemDonHang(context, "Xem sản phẩm");
      else if (widget.page == 2)
        return ListItemDonHang(context, "Xem chi tiết");
      else
        return ListItemDonHang(context, "Hủy bỏ");
    }());
  }
}
