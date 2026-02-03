import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  // دالة للمساعدة على الانتقال لغلق أي Dialog مفتوح
  void _navigateAndCloseDialog(BuildContext context, String routeName) {
    // أولًا نغلق أي Dialog مفتوح (لو موجود)
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // يقفل الـ AlertDialog أو الـ Drawer المفتوح
    }
    // بعد كده ننتقل للصفحة المطلوبة
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: const Color(0xFF00A7B3),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF00A7B3)),
              accountName: const Text("Admin"),
              accountEmail: const Text("admin@lifelink.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                // اغلق أي Dialog وارجع للـ Dashboard
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text("Blood Inventory"),
              onTap: () {
                _navigateAndCloseDialog(context, "bloodInventoryAdmin");
              },
            ),

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Users"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Reports"),
              onTap: () {},
            ),

            const Spacer(),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF00A7B3)),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: const Center(
        child: Text("Admin Dashboard", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
