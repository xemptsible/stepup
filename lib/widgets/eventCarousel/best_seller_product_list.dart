import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:stepup/widgets/eventCarousel/slider_card.dart';

class BestSellerProductList extends StatefulWidget {
  const BestSellerProductList({super.key});

  @override
  State<BestSellerProductList> createState() => _BestSellerProductListState();
}

class _BestSellerProductListState extends State<BestSellerProductList> {
  int selectedIndex = 0;
  final items = [
    {
      'index': 1,
      'color': const Color.fromARGB(255, 201, 18, 5),
      'title': 'Chỉ trong hôm nay',
      'detail': 'Giảm giá 25% !',
      'textColor': Colors.white,
      'img': "event1.png",
    },
    {
      'index': 2,
      'color': Colors.yellow,
      'title': 'Chỉ trong hôm nay',
      'detail': 'Giảm giá 25% !',
      'textColor': Colors.black,
      'img': "event2.png",
    },
    {
      'index': 3,
      'color': Colors.black,
      'title': 'Chỉ trong hôm nay',
      'detail': 'Giảm giá 25% !',
      'textColor': Colors.white,
      'img': "event3.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: items.map((e) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  child: SliderCard(
                    title: e['title'].toString(),
                    detail: e['detail'].toString(),
                    color: e['color'] as Color,
                    img: e['img'].toString(),
                    textColor: e['textColor'] as Color,
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  selectedIndex = index;
                });
              },
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              height: MediaQuery.of(context).size.height * 0.2,
              viewportFraction: 0.8,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1500)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: DotsIndicator(
            dotsCount: items.length,
            position: selectedIndex,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(25.0, 9.0),
              activeColor: Colors.black,
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        )
      ],
    );
  }
  // return FutureBuilder(
  //     future: _loadProData(),
  //     builder: (BuildContext context, snapshot) {
  // return CarouselSlider(
  //   items: [
  //     for (int i = 0; i < proList.length; i += 2)
  //       Builder(builder: (BuildContext context) {
  //         return Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             if (i < proList.length)
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.pushNamed(context, "/productDetail");
  //                 },
  //                 child: ProductCard(
  //                   image: proList[i].img.toString().trim(),
  //                   name: proList[i].name.toString().trim(),
  //                   price: proList[i].price as int,
  //                 ),
  //               ),
  //             if (i + 1 < proList.length)
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.pushNamed(context, "/productDetail");
  //                 },
  //                 child: ProductCard(
  //                   image: proList[i + 1].img.toString().trim(),
  //                   name: proList[i + 1].name.toString().trim(),
  //                   price: proList[i + 1].price as int,
  //                 ),
  //               ),
  //           ],
  //         );
  //       }),
  //   ],
  //   options: CarouselOptions(
  //       height: 400.0,
  //       viewportFraction: 1.0,
  //       autoPlay: true,
  //       autoPlayAnimationDuration: Duration(milliseconds: 1500)),
  // );
  //     });
}
