import 'package:flutter/material.dart';
import 'package:stepup/test/model/shoe.dart';

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

  Widget ListItemDaGiao(BuildContext context) {
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
                child: Image.network(
                    "https://ananas.vn/wp-content/uploads/pro_track6_A6T002_1.jpg"),
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
                            discount: shoe.discount,
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
                                    "Xem sản phẩm",
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

  Widget ListItemDangGiao(BuildContext context) {
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
                child: Image.network(
                    "https://ananas.vn/wp-content/uploads/pro_track6_A6T002_1.jpg"),
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
                            discount: shoe.discount,
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
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 57, 82, 196)),
                                // color: Color.fromARGB(255, 57, 82, 196),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Xem chi tiết",
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

  Widget ListItemDaHuy(BuildContext context) {
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
                child: Image.network(
                    "https://ananas.vn/wp-content/uploads/pro_track6_A6T002_1.jpg"),
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
                            discount: shoe.discount,
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
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 57, 82, 196)),
                                // color: Color.fromARGB(255, 57, 82, 196),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Mua Lại",
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
        return ListItemDaGiao(context);
      else if (page == 2)
        return ListItemDangGiao(context);
      else
        return ListItemDaHuy(context);
    }());
  }
}
