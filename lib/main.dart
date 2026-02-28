import 'package:flutter/material.dart';
import 'package:lifelink/screen/ScaleDemo.dart';
//import 'package:lifelink/auth.dart';
import 'package:lifelink/screen/login_screen.dart';
import 'package:lifelink/screen/signup_screen.dart';
import 'package:lifelink/screen/admin.dart';
import 'package:lifelink/screen/blood_Inventory.dart';
import 'package:lifelink/screen/my_data_page.dart';
import 'package:lifelink/screen/home_screen.dart';
import 'package:lifelink/screen/blood_type_page.dart';
import 'package:lifelink/screen/about_page.dart';
import 'package:lifelink/screen/delivery_page.dart';
import 'package:lifelink/network_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IntroScreen(),
      routes: {
        "scaleDemo": (context) => const IntroScreen(),
        "admin": (context) => const NetworkWrapper(child: AdminPage()),
        "homeScreen": (context) => const NetworkWrapper(child: HomeScreen()),
        "bloodInventoryAdmin": (context) =>
            const NetworkWrapper(child: BloodInventoryAdminPage()),
        "loginScreen": (context) => const LoginScreen(),
        "signupScreen": (context) => const SignupScreen(),
        "myData": (context) => const NetworkWrapper(child: MyDataScreen()),
        "aboutPage": (context) => const NetworkWrapper(child: AboutPage()),
        "bloodTypePage": (context) =>
            const NetworkWrapper(child: BloodTypePage()),
        "deliverypage": (context) =>
            const NetworkWrapper(child: DeliveryPage()),
      },
    );
  }
}
