import 'package:flutter/material.dart';

class BloodInventoryAdminPage extends StatefulWidget {
  const BloodInventoryAdminPage({super.key});

  @override
  State<BloodInventoryAdminPage> createState() =>
      _BloodInventoryAdminPageState();
}

class _BloodInventoryAdminPageState extends State<BloodInventoryAdminPage> {
  final List<String> bloodTypes = const [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

  final List<String> hospitals = const [
    "مستشفى السلام",
    "مستشفى النور",
    "مستشفى الرحمة",
  ];

  void _showEditDialog(String bloodType) {
    String? selectedHospital;
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.edit, color: Color(0xFF00A7B3)),
            const SizedBox(width: 8),
            Text("Edit $bloodType"),
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
              onChanged: (value) {
                selectedHospital = value;
                quantityController.text = "0"; // قيمة مؤقتة
              },
            ),
            const SizedBox(height: 20),
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
          // Cancel
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey[200],
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          // Save
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A7B3),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (selectedHospital == null || quantityController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please complete all fields")),
                );
                return;
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "$bloodType in $selectedHospital set to ${quantityController.text} bags ✅",
                  ),
                ),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Inventory"),
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
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text("Blood Inventory"),
              onTap: () => Navigator.pop(context),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bloodTypes.length,
        itemBuilder: (context, index) {
          final type = bloodTypes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.bloodtype, color: Color(0xFF00A7B3)),
              title: Text(
                type,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Total bags: 0"), // مجرد واجهة
              trailing: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A7B3),
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _showEditDialog(type),
                icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                label: const Text("Edit"),
              ),
            ),
          );
        },
      ),
    );
  }
}
