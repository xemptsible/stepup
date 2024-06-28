import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stepup/screens/login.dart';
import 'package:stepup/screens/register.dart';
import 'package:stepup/utilities/const.dart';
// import 'utilities/font.dart';
import 'global/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Đăng nhập tài khoản ẩn danh tạm thời

  // try {
  //   await FirebaseAuth.instance.signInAnonymously();
  // } on FirebaseAuthException catch (e) {
  //   switch (e.code) {
  //     case "operation-not-allowed":
  //       logger.e("Anonymous auth hasn't been enabled for this project.");
  //       break;
  //     default:
  //       logger.e("Unknown error.");
  //   }
  // }

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      logger.d('User is currently signed out!');
    } else if (user.isAnonymous) {
      logger.d("Signed in with temporary account.");
    } else {
      logger.d('User is signed in!');
    }
  });

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
    return MaterialApp(
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: const StartScreen());
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Chào mừng đến StepUP'),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(imagePath),
                    fit: BoxFit.fill,
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
