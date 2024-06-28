import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stepup/utilities/const.dart';
import 'package:stepup/global/widgets.dart';

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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textField(
                              _emailController,
                              "Email",
                              "Enter your email",
                              const Icon(Icons.email),
                              false,
                            ),
                            textField(
                              _usernameController,
                              "Username",
                              "Enter your username",
                              const Icon(Icons.person),
                              false,
                            ),
                            pwTextField(
                              _passwordController,
                              _confirmPWController,
                              "New password",
                              "Enter your password",
                              const Icon(Icons.password),
                              true,
                            ),
                            pwTextField(
                              _confirmPWController,
                              _passwordController,
                              "Confirm password",
                              "Re-enter your password",
                              const Icon(Icons.check),
                              true,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await linkAnonInFirebase(
                                      _emailController,
                                      _passwordController,
                                    );
                                  }
                                },
                                child: const Text("Đăng ký"),
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

  Future<void> fetchData(String? message) async {
    /// Getting the current context of the widget in the widget tree
    final context = _formKey.currentContext;

    if (context != null && context.mounted) {
      /// statements after async gap without warning
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.toString()),
      ));
    }
  }

  Future<void> createUserInFirebase(
      TextEditingController tecEmail, TextEditingController tecPassword) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: tecEmail.text,
        password: tecPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      logger.e('Failed with error code: ${e.code}');
      logger.e(e.message);
      fetchData(e.message);
    }
  }

  Future<void> linkAnonInFirebase(
      TextEditingController tecEmail, TextEditingController tecPassword) async {
    final credential = EmailAuthProvider.credential(
        email: tecEmail.text, password: tecPassword.text);

    try {
      await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      fetchData(e.message);
    }
  }
}
