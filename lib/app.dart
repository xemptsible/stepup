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
  late bool selected;

  final screens = [
    const HomePage(),
    const FavoritePage(),
    const CartPage(),
    const AccountPage(),
  ];

  _loadTitle(int index) {
    switch (index) {
      case 0:
        return 'StepUP';
      case 1:
        return 'Yêu thích';
      case 2:
        return 'Giỏ hàng';
      case 3:
        return '';
      default:
        return 'Error!';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    selected = false;
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            _loadTitle(selectedIndex),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          forceMaterialTransparency: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
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
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            setState(() {
              selected = true;
              selectedIndex = value;
              _pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            });
          },
          selectedIndex: selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Trang chủ',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_border),
              label: 'Yêu thích',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Giỏ hàng',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Tài khoản',
            ),
          ],
        ),
      ),
    );
  }
}
