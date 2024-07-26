import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stepup/data/api/api.dart';
import 'package:stepup/data/models/account_model.dart';

import 'package:stepup/screens/signIn_Up/login.dart';
import 'package:stepup/utilities/const.dart';
import 'package:stepup/global/functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPWController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPWController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Đăng ký'),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textField(
                              _emailController,
                              "Email",
                              "",
                              const Icon(Icons.email),
                              false,
                            ),
                            textField(
                              _usernameController,
                              "Tên người dùng",
                              "",
                              const Icon(Icons.person),
                              false,
                            ),
                            pwTextField(
                              _passwordController,
                              _confirmPWController,
                              "Mật khẩu mới",
                              "",
                              const Icon(Icons.password),
                              true,
                            ),
                            pwTextField(
                              _confirmPWController,
                              _passwordController,
                              "Xác nhận mật khẩu",
                              "",
                              const Icon(Icons.check),
                              true,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: FilledButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await taoTaiKhoanTrongFirebase(
                                        _emailController,
                                        _passwordController,
                                      );
                                    }
                                  },
                                  child: const Text("Đăng ký"),
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
          ),
        ],
      ),
    );
  }

  Future<void> errorDialogDangKy(String? message) async {
    /// Getting the current context of the widget in the widget tree
    final context = _formKey.currentContext;

    if (context != null && context.mounted) {
      /// statements after async gap without warning
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Lỗi đăng ký'),
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

  Future<void> taoTaiKhoanTrongFirebase(
      TextEditingController tecEmail, TextEditingController tecPassword) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: tecEmail.text,
        password: tecPassword.text,
      );
      //post account lên api
      Account newAcc = Account(
          Email: _emailController.text,
          Password: _passwordController.text,
          UserName: _usernameController.text);
      ApiService apiService = ApiService();
      await apiService.postAccount(newAcc);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      logger.e('Failed with error code: ${e.code}');
      logger.e(e.message);
      if (e.code == 'weak-password') {
        errorDialogDangKy('Mật khẩu nên đặt từ 6 ký tự trở lên');
      } else if (e.code == 'email-already-in-use') {
        errorDialogDangKy('Tài khoản đã tồn tại');
      } else if (e.code == 'network-request-failed') {
        errorDialogDangKy(
            'Bị mất hoặc không có kết nối mạng khi đang tạo tài khoản');
      } else {
        errorDialogDangKy(e.message);
      }
    }
  }

  // Future<void> linkAnonInFirebase(
  //     TextEditingController tecEmail, TextEditingController tecPassword) async {
  //   final credential = EmailAuthProvider.credential(
  //       email: tecEmail.text, password: tecPassword.text);

  //   try {
  //     await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     fetchData(e.message);
  //   }
  // }
}
