import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // 🔴 أيقونة التطبيق
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red.shade100,
              child: const Icon(Icons.bloodtype, size: 60, color: Colors.red),
            ),

            const SizedBox(height: 20),

            const Text(
              "LifeLink",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "تطبيق لإدارة التبرع بالدم وتنظيم مخزون أكياس الدم بين المستشفيات.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            Divider(color: Colors.grey.shade300),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.person, color: Colors.red),
              title: const Text("Developer"),
              subtitle: const Text("كريم - Flutter Developer"),
            ),

            ListTile(
              leading: const Icon(Icons.email, color: Colors.red),
              title: const Text("Email"),
              subtitle: const Text("lifelink@example.com"),
            ),

            ListTile(
              leading: const Icon(Icons.phone, color: Colors.red),
              title: const Text("Phone"),
              subtitle: const Text("+20 123 456 7890"),
            ),

            const SizedBox(height: 40),

            const Text("Version 1.0.0", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
