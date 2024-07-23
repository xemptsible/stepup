// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepup/app.dart';

import 'package:stepup/data/providers/account_vm.dart';
import 'package:stepup/screens/signIn_Up/register.dart';
import 'package:stepup/utilities/const.dart';
import 'package:stepup/global/functions.dart';

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
                              xuLyDangNhap(
                                  _emailController, _passwordController);
                              Provider.of<AccountVMS>(context, listen: false)
                                  .setCurrentAcc(_emailController.text);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const App(),
                              //     ));
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

  Future<void> errorDialogDangNhap(String? message) async {
    /// Getting the current context of the widget in the widget tree
    final context = _formKey.currentContext;

    if (context != null && context.mounted) {
      /// statements after async gap without warning
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Lỗi đăng nhập'),
          content: Text(message ?? 'Không biết lỗi'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> xuLyDangNhap(
      TextEditingController email, TextEditingController password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then(
        (value) {
          if (value.user != null) {
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
    } on FirebaseAuthException catch (e) {
      logger.e('Failed with error code: ${e.code}');
      logger.e(e.message);
      errorDialogDangNhap(e.message);
    }
  }
}
