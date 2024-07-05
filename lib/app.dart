import 'package:flutter/material.dart';

import 'package:stepup/screens/mainPage/account.dart';
import 'package:stepup/screens/mainPage/cart_page.dart';
import 'package:stepup/screens/mainPage/favorite.dart';
import 'package:stepup/screens/mainPage/home_body.dart';

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
    final screens = [HomePage(), FavoritePage(), CartPage(), AccountPage()];
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
                  if (index == selectedIndex) {
                    selected = false;
                  }
                  if (!selected) selectedIndex = index;
                });
              },
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                setState(() {
                  selected = true;
                  selectedIndex = value;
                  _pageController.animateToPage(value,
                      duration: Duration(milliseconds: 500),
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
                  label: "Trang chủ",
                ),
                BottomNavigationBarItem(
                    activeIcon: Container(
                      width: 60,
                      height: 30,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.black,
                    ),
                    label: "Yêu thích"),
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
