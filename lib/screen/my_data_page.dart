import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lifelink/screen/home_screen.dart';
import 'package:lifelink/screen/about_page.dart';

class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  int selectedIndex = 0; // MyData يكون مختار أولاً

  // الصفحات المختلفة
  final List<Widget> pages = [
    const MyDataBody(), // index 0
    const HomeScreen(), // index 1
    const AboutPage(), // index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar يظهر فقط في MyData
      appBar: selectedIndex == 0
          ? AppBar(
              backgroundColor: const Color(0xFF00A7B3),
              centerTitle: true,
              title: const Text(
                "My Data",
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          : null,

      // محتوى الصفحة حسب المحدد
      body: IndexedStack(index: selectedIndex, children: pages),

      // الشريط السفلي المنحني
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xffF5F6FA),
        color: const Color(0xFF00A7B3),
        animationDuration: const Duration(milliseconds: 300),
        index: selectedIndex,
        items: const [
          Icon(Icons.person, size: 30, color: Colors.white), // MyData
          Icon(Icons.home, size: 30, color: Colors.white), // Home
          Icon(Icons.info_outline, size: 30, color: Colors.white), // About
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

// ===== جسم صفحة MyData =====
class MyDataBody extends StatelessWidget {
  final String? name;
  final String? nationalId;
  final String? phone;
  final String? email;

  const MyDataBody({
    this.name,
    this.nationalId,
    this.phone,
    this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xffE6E8EC),
              child: Icon(Icons.person, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 25),
            buildDataItem("الاسم", name),
            buildDataItem("الرقم القومي", nationalId),
            buildDataItem("رقم الهاتف", phone),
            buildDataItem("البريد الإلكتروني", email),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  "تسجيل الخروج",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataItem(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xffF1F2F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value?.isNotEmpty == true ? value! : "--",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
