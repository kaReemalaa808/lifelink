import 'package:flutter/material.dart';
import 'package:lifelink/screen/admin.dart';
import 'package:lifelink/screen/blood_Inventory.dart';
import 'package:lifelink/screen/login_screen.dart';
import 'package:lifelink/screen/signup_screen.dart';
import 'package:lifelink/screen/home_screen.dart';
import 'package:lifelink/screen/blood_type_page.dart';
import 'package:lifelink/screen/Pay_Now.dart';
import 'package:lifelink/screen/invoice_page.dart';
import 'package:lifelink/screen/my_data_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
      routes: {
        "admin": (context) => const AdminPage(),
        "bloodInventoryAdmin": (context) => const BloodInventoryAdminPage(),
        "loginScreen": (context) => const LoginScreen(),
        "signupScreen": (context) => const SignupScreen(),
        "homeScreen": (context) => const HomeScreen(),
        "bloodTypePage": (context) => const BloodTypePage(),
        "payNow": (context) => const PayNow(),
        "invoicePage": (context) => const InvoicePage(amount: 0, method: ''),
        "myData": (context) => const MyDataScreen(),
      },
    );
  }
}
