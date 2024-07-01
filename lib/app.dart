import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stepup/screens/account.dart';
import 'package:stepup/screens/home_body.dart';
import 'package:stepup/screens/product_detail_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int selectedIndex = 0;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    bool selected = false;
  }

  TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [HomePage(), ProductDetail(), AccountPage()];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                  _pageController.animateToPage(value,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                });
              },
              showSelectedLabels: true,
              currentIndex: selectedIndex,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Container(
                    width: 60,
                    height: 30,
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  ),
                  label: "Home",
                ),
                // BottomNavigationBarItem(
                //     activeIcon: Container(
                //       width: 60,
                //       height: 30,
                //       child: Icon(
                //         Icons.favorite,
                //         color: Colors.white,
                //       ),
                //       decoration: BoxDecoration(
                //           color: Colors.blue,
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     icon: Icon(
                //       Icons.favorite_border_outlined,
                //       color: Colors.black,
                //     ),
                // label: "A"),
                BottomNavigationBarItem(
                    activeIcon: Container(
                      width: 60,
                      height: 30,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                    label: "Giỏ hàng"),
                BottomNavigationBarItem(
                    activeIcon: Container(
                      width: 60,
                      height: 30,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                    ),
                    label: "Tài khoản"),
              ],
            )),
      ),
    );
  }
}
