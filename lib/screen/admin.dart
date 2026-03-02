import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // بيانات تجريبية
  int usersCount = 720;
  int hospitalsCount = 90;
  int bagsAvailable = 450;
  int bagsReserved = 320;
  int bagsToDeliver = 100;
  int bagsDelivered = 280;

  void _navigateAndCloseDialog(BuildContext context, String routeName) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.of(context).pushNamed(routeName);
  }

  Widget _buildDashboardCard(
    String title,
    int count,
    IconData icon,
    Color color,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 16),
            Text(
              "$count",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("   Admin Home   "),
        backgroundColor: const Color(0xFF00A7B3),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_open, color: Colors.white, size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: "Cairo",
        ),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF00A7B3)),
              accountName: Text("Admin"),
              accountEmail: Text("admin@lifelink.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.admin_panel_settings,
                  color: Color(0xFF00A7B3),
                  size: 40,
                ),
              ),
            ),
            // الصفحة الحالية (Home) بلون اللوجو
            ListTile(
              leading: const Icon(
                Icons.admin_panel_settings,
                color: Color(0xFF00A7B3),
              ),
              title: const Text(
                "Admin Home",
                style: TextStyle(
                  color: Color(0xFF00A7B3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            // باقي الصفحات باللون الأسود
            ListTile(
              leading: const Icon(
                Icons.inventory_2_outlined,
                color: Colors.black,
              ),
              title: const Text(
                "Blood Inventory",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                _navigateAndCloseDialog(context, "bloodInventoryAdmin");
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt, color: Colors.black),
              title: const Text(
                "Orders",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                _navigateAndCloseDialog(context, "adminOrdersScreen");
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart, color: Colors.black),
              title: const Text(
                "Reports",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {},
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: .9,
          children: [
            _buildDashboardCard(
              "Users",
              usersCount,
              Icons.people,
              Colors.orange,
            ),
            _buildDashboardCard(
              "Hospitals",
              hospitalsCount,
              Icons.local_hospital,
              Colors.red,
            ),
            _buildDashboardCard(
              "Available",
              bagsAvailable,
              Icons.inventory,
              Colors.blue,
            ),
            _buildDashboardCard(
              "Reserved",
              bagsReserved,
              Icons.pending_actions,
              Colors.green,
            ),
            _buildDashboardCard(
              "To Deliver",
              bagsToDeliver,
              Icons.local_shipping,
              Colors.amber,
            ),
            _buildDashboardCard(
              "Delivered",
              bagsDelivered,
              Icons.check_circle,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
