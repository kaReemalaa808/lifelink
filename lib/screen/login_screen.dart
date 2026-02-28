import 'package:flutter/material.dart';
import 'package:lifelink/internet_service.dart';
import 'package:lifelink/network_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _messageVisible = false;

  /// منع تكرار الرسائل
  void showMessage(String text, {Color color = Colors.red}) {
    if (_messageVisible) return;

    _messageVisible = true;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(text),
            backgroundColor: color,
            duration: const Duration(seconds: 2),
          ),
        )
        .closed
        .then((_) {
          _messageVisible = false;
        });
  }

  /// تنفيذ تسجيل الدخول
  Future<void> signIn() async {
    if (!mounted) return;

    if (_emailController.text.contains('admin')) {
      Navigator.of(context).pushNamed("admin");
    } else if (_emailController.text.contains('homeScreen')) {
      Navigator.of(context).pushNamed("homeScreen");
    } else {
      showMessage("Invalid account");
    }
  }

  /// زر تسجيل الدخول
  Future<void> handleLogin() async {
    // تحقق من الحقول
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showMessage("Please fill in all fields");
      return;
    }

    // تحقق من الإنترنت
    bool hasInternet = await InternetService.hasInternet();
    if (!hasInternet) {
      showMessage("❌ No Internet Connection");
      return;
    }

    // تنفيذ تسجيل الدخول
    await signIn();
  }

  void openSignupScreen() {
    Navigator.of(context).pushNamed("signupScreen");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkWrapper(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF00A7B3),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "LifeLink",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Cairo",
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("images/logo.png", width: 250, height: 250),
                  const Text(
                    "LIFE LINK",
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A7B3),
                    ),
                  ),
                  const Text(
                    "welcome back! Please \n login to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF00A7B3),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Sign in Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: handleLogin,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A7B3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Sign up navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      GestureDetector(
                        onTap: openSignupScreen,
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}