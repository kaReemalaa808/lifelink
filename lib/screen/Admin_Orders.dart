import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final Color mainColor = const Color(0xFF00A7B3);
  String? selectedHospital;

  // Mock Data
  List<Map<String, dynamic>> allOrders = [
    {
      "id": "201",
      "name": "John Doe",
      "status": "active",
      "isViewed": false,
      "nationalId": "29501012101234",
      "phone": "01023456789",
      "bloodType": "O+",
      "source": "Al-Qasr Al-Aini Hospital",
      "target": "Al-Demerdash Hospital",
      "orderDate": "2024-06-01",
      "receiveDate": "2024-06-03",
    },
    {
      "id": "202",
      "name": "Sarah Ahmed",
      "status": "active",
      "isViewed": true,
      "nationalId": "29805051401234",
      "phone": "01145678901",
      "bloodType": "A-",
      "source": "Ain Shams Hospital",
      "target": "Al-Helal Hospital",
      "orderDate": "2024-06-02",
      "receiveDate": "2024-06-04",
    },
  ];

  List<String> get hospitals =>
      allOrders.map((e) => e['source'].toString()).toSet().toList();

  // دالة التنقل وإغلاق القائمة الجانبية
  void _navigateAndCloseDrawer(BuildContext context, String routeName) {
    Navigator.pop(context); // إغلاق الـ Drawer
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 2,
          toolbarHeight: 70,
          // أيقونة الـ Drawer هتظهر هنا تلقائياً لأننا أضفنا Drawer في الـ Scaffold
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Orders Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
              fontFamily: "Cairo", // نفس خط صفحة المخزن
            ),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
                size: 28,
              ),
              onSelected: (val) => setState(
                () => selectedHospital = (val == "All") ? null : val,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "All",
                  child: Text("Show All", style: TextStyle(fontSize: 16)),
                ),
                ...hospitals.map(
                  (h) => PopupMenuItem(
                    value: h,
                    child: Text(h, style: const TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: const [
              Tab(text: "Pending"),
              Tab(text: "Delivered"),
              Tab(text: "Failed"),
            ],
          ),
        ),

        // --- إضافة الـ Drawer اللي طلبتها بالظبط ---
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
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text("Admin home"),
                onTap: () => _navigateAndCloseDrawer(context, "admin"),
              ),
              ListTile(
                leading: const Icon(
                  Icons.list_alt,
                  color: Color(0xFF00A7B3),
                ), // خليت دي لونها مميز لأنها الصفحة الحالية
                title: const Text("Orders"),
                onTap: () => Navigator.pop(
                  context,
                ), // إغلاق فقط لأننا في صفحة الاوردرز فعلاً
              ),
              ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: const Text("Inventory"),
                onTap: () => _navigateAndCloseDrawer(
                  context,
                  "bloodInventoryAdminPage",
                ), // تأكد من اسم الـ route
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

        // --- نهاية الـ Drawer ---
        body: Column(
          children: [
            if (selectedHospital != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                color: mainColor.withOpacity(0.1),
                child: Row(
                  children: [
                    Text(
                      "Filter: $selectedHospital",
                      style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => setState(() => selectedHospital = null),
                      child: Icon(Icons.close, size: 24, color: mainColor),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildOrdersList("active"),
                  _buildOrdersList("delivered"),
                  _buildOrdersList("failed"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // بقية دوال الصفحة (نفس الكود السابق للـ List والـ Card والـ Update)
  Widget _buildOrdersList(String status) {
    final filtered = allOrders
        .where(
          (o) =>
              o['status'] == status &&
              (selectedHospital == null || o['source'] == selectedHospital),
        )
        .toList();
    if (filtered.isEmpty)
      return const Center(
        child: Text(
          "No orders found",
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      );

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filtered.length,
      itemBuilder: (context, index) => _orderCard(filtered[index], status),
    );
  }

  Widget _orderCard(Map<String, dynamic> order, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          if (order['isViewed'] == false)
            setState(() => order['isViewed'] = true);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: status == "active"
                    ? mainColor.withOpacity(0.08)
                    : (status == "delivered"
                          ? Colors.green[50]
                          : Colors.red[50]),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Order #${order['id']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: 18,
                        ),
                      ),
                      if (order['isViewed'] == false && status == "active")
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "NEW",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 26,
                    ),
                    onPressed: () => _confirmDelete(order['id']),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _infoRow(
                    Icons.person,
                    "Patient Name",
                    order['name'],
                    isBold: true,
                    titleSize: 15,
                  ),
                  const SizedBox(height: 4),
                  _infoRow(Icons.badge, "National ID", order['nationalId']),
                  _infoRow(Icons.phone, "Phone Number", order['phone']),
                  _infoRow(
                    Icons.bloodtype,
                    "Blood Type",
                    order['bloodType'],
                    valueColor: Colors.red,
                    isBold: true,
                    valueSize: 16,
                  ),
                  const Divider(height: 25),
                  _infoRow(Icons.local_hospital, "From", order['source']),
                  _infoRow(Icons.business, "To", order['target']),
                  const Divider(height: 25),
                  _infoRow(
                    Icons.calendar_today,
                    "Order Date",
                    order['orderDate'],
                  ),
                  _infoRow(
                    Icons.event_available,
                    "Delivery Date",
                    order['receiveDate'],
                    valueColor: mainColor,
                    isBold: true,
                    valueSize: 15,
                  ),
                  if (status == "active") _buildActionButtons(order['id']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(String id) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _updateStatus(id, "delivered"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                "Delivered",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () => _updateStatus(id, "failed"),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                "Not Received",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateStatus(String id, String status) {
    setState(() {
      int idx = allOrders.indexWhere((o) => o['id'] == id);
      if (idx != -1) {
        allOrders[idx]['status'] = status;
        allOrders[idx]['isViewed'] = true;
      }
    });
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text(
          "Delete Order",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to delete this order?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text("Cancel", style: TextStyle(fontSize: 16)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => allOrders.removeWhere((o) => o['id'] == id));
              Navigator.pop(c);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value, {
    Color? valueColor,
    bool isBold = false,
    double titleSize = 14,
    double valueSize = 14,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: mainColor),
          const SizedBox(width: 12),
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: valueSize,
                color: valueColor ?? Colors.black87,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
