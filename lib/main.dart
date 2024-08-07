import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/app.dart';
import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/data/providers/favorite_vm.dart';
import 'package:stepup/data/providers/filter_vm.dart';
import 'package:stepup/data/providers/product_vm.dart';
import 'package:stepup/screens/mainPage/account.dart';
import 'package:stepup/screens/mainPage/checkout.dart';
import 'package:stepup/screens/mainPage/order_history.dart';

import 'package:stepup/screens/mainPage/search_page.dart';

import 'package:stepup/screens/signIn_Up/login.dart';
import 'package:stepup/screens/mainPage/product_detail_page.dart';
import 'package:stepup/screens/signIn_Up/register.dart';

import 'package:stepup/utilities/const.dart';
// import 'utilities/font.dart';
import 'global/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    // TextTheme textTheme = createTextTheme(context, "Alata", "Alata");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductVMS(),
        ),
        ChangeNotifierProvider(create: (context) => FilterVMS()),
        ChangeNotifierProvider(create: (context) => FavoriteVm()),
        ChangeNotifierProvider(create: (context) => AccountVMS()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/start": (context) => const StartScreen(),
            "/login": (context) => const LoginScreen(),
            "/homePage": (context) => const App(),
            "/productDetail": (context) => const ProductDetail(),
            "/account": (context) => const AccountPage(),
            "/search": (context) => const SearchPage(),
            "/history": (context) => const OrderHistory(),
            "/checkout": (context) => const Checkout(),
          },
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          home: const StartScreen()),
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Future<void> kiemTraDangNhapTrongApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          logger.d('User is currently signed out!');
        } else if (mounted && user.emailVerified == true) {
          AsyncSnapshot.waiting;

          Provider.of<AccountVMS>(context, listen: false)
              .setCurrentAcc(user.email!);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const App(),
            ),
            ModalRoute.withName('/homePage'),
          );
        }
      },
    );
  }

  @override
  void initState() {
    kiemTraDangNhapTrongApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            automaticallyImplyLeading: false,
            title: Text('Chào mừng đến StepUP'),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image(
                    image: AssetImage(imagePath),
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                    opacity: AlwaysStoppedAnimation(.4),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('Đăng nhập'),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 36),
                          child: FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text('Đăng ký'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
