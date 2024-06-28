// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stepup/screens/register.dart';
import 'package:stepup/utilities/const.dart';
import 'package:stepup/global/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Đăng nhập'),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            textField(_emailController, "Email", "",
                                const Icon(Icons.email), false),
                            textField(
                              _passwordController,
                              "Mật khẩu",
                              "",
                              const Icon(Icons.password),
                              true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                          },
                          child: const Text(
                            "Quên mật khẩu?",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            }
                          },
                          child: const Text("Đăng nhập"),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Chưa có tài khoản? Đăng ký",
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

  Future<void> xuLyDangNhap() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "barry.allen@example.com", password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      logger.e('Failed with error code: ${e.code}');
      logger.e(e.message);
    }
  }
}
