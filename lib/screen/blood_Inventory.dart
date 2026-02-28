import 'package:flutter/material.dart';
import 'package:lifelink/internet_service.dart';
import 'package:lifelink/network_wrapper.dart';

class BloodInventoryAdminPage extends StatefulWidget {
  const BloodInventoryAdminPage({super.key});

  @override
  State<BloodInventoryAdminPage> createState() =>
      _BloodInventoryAdminPageState();
}

class _BloodInventoryAdminPageState extends State<BloodInventoryAdminPage> {
  final List<String> bloodTypes = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

  final List<String> hospitals = [
    "مستشفى السلام",
    "مستشفى النور",
    "مستشفى الرحمة",
  ];

  bool _messageVisible = false;

  /// منع تكرار الرسائل
  void showMessage(String text, {Color color = Colors.black}) {
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
        .then((_) => _messageVisible = false);
  }

  void _navigateAndCloseDrawer(BuildContext context, String routeName) {
    Navigator.pop(context);
    Navigator.pushNamed(context, routeName);
  }

  /// Edit Dialog
  void _showEditDialog(String bloodType) {
    String? selectedHospital;
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.edit, color: Color(0xFF00A7B3)),
            SizedBox(width: 8),
            Text("Edit Blood Stock"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Select Hospital",
                border: OutlineInputBorder(),
              ),
              items: hospitals.map((hospital) {
                return DropdownMenuItem<String>(
                  value: hospital,
                  child: Text(hospital),
                );
              }).toList(),
              onChanged: (value) => selectedHospital = value,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Number of Bags",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A7B3),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (selectedHospital == null || quantityController.text.isEmpty) {
                showMessage("Please fill all fields", color: Colors.red);
                return;
              }

              bool hasInternet = await InternetService.hasInternet();
              if (!hasInternet) {
                showMessage("❌ No Internet Connection", color: Colors.red);
                return;
              }

              Navigator.pop(context);
              showMessage(
                "$bloodType in $selectedHospital set to ${quantityController.text} bags ✅",
                color: Colors.green,
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  /// Add Hospital Dialog
  void _showAddHospitalDialog(String bloodType) {
    final TextEditingController hospitalController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.add, color: Color(0xFF00A7B3)),
            SizedBox(width: 8),
            Text("Add Hospital"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: hospitalController,
              decoration: const InputDecoration(
                labelText: "Hospital Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Initial Bags",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A7B3),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (hospitalController.text.isEmpty ||
                  quantityController.text.isEmpty) {
                showMessage("Please fill all fields", color: Colors.red);
                return;
              }

              bool hasInternet = await InternetService.hasInternet();
              if (!hasInternet) {
                showMessage("❌ No Internet Connection", color: Colors.red);
                return;
              }

              setState(() {
                hospitals.add(hospitalController.text);
              });

              Navigator.pop(context);

              showMessage(
                "${hospitalController.text} added with ${quantityController.text} bags ✅",
                color: Colors.green,
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NetworkWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Blood Inventory Management",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Cairo",
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          backgroundColor: const Color(0xFF00A7B3),
          iconTheme: const IconThemeData(color: Colors.white),
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
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text("Admin home"),
                onTap: () => _navigateAndCloseDrawer(context, "admin"),
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
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: bloodTypes.map((type) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(
                    Icons.bloodtype,
                    color: Color(0xFF00A7B3),
                  ),
                  title: Text(
                    type,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("Total bags: --"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A7B3),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _showEditDialog(type),
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text("Edit"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _showAddHospitalDialog(type),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text("Add"),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
