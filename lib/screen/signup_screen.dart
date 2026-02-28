import 'package:flutter/material.dart';
import 'package:lifelink/internet_service.dart';
import 'package:lifelink/network_wrapper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _phoneNumberController = TextEditingController();
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

  /// تنفيذ إنشاء الحساب بدون reload
  Future<void> signUp() async {
    if (!mounted) return;

    print("username: ${_usernameController.text}");
    print("national ID: ${_nationalIdController.text}");
    print("phone number: ${_phoneNumberController.text}");
    print("email: ${_emailController.text}");
    print("password: ${_passwordController.text}");

    showMessage("✅ Account created successfully", color: Colors.green);
  }

  /// زر signup
  Future<void> handleSignup() async {
    // تحقق من الحقول
    if (_usernameController.text.isEmpty ||
        _nationalIdController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      showMessage("Please fill in all fields");
      return;
    }

    // تحقق من الإنترنت
    bool hasInternet = await InternetService.hasInternet();
    if (!hasInternet) {
      showMessage("❌ No Internet Connection");
      return;
    }

    // تنفيذ التسجيل
    await signUp();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nationalIdController.dispose();
    _phoneNumberController.dispose();
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
                  Image.asset("images/logo.png", width: 200, height: 200),
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
                    "welcome! Here you can Sign Up",
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF00A7B3),
                    ),
                  ),
                  const SizedBox(height: 20),

                  buildField(_usernameController, "UserName"),
                  buildField(_nationalIdController, "National ID",
                      keyboard: TextInputType.number),
                  buildField(_phoneNumberController, "Phone number",
                      keyboard: TextInputType.phone),
                  buildField(_emailController, "Email",
                      keyboard: TextInputType.emailAddress),
                  buildField(_passwordController, "Password", obscure: true),
                  const SizedBox(height: 15),

                  // Sign Up Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: handleSignup,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A7B3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign Up",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// TextField Widget
  Widget buildField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: controller,
            keyboardType: keyboard,
            obscureText: obscure,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
      ),
    );
  }
}