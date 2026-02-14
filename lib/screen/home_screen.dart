import 'package:flutter/material.dart';
import 'package:lifelink/screen/blood_type_page.dart';
import 'package:lifelink/screen/my_data_page.dart';
import 'package:lifelink/screen/about_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  final List<Widget> pages = [
    const MyDataScreen(),
    const HomeContent(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xff1FA5A9),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Data"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////
/// ده محتوى الصفحة الرئيسية اللي كان موجود عندك
////////////////////////////////////////////////////////////////

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الرئيسية",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text("Home", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: topCard(context, Icons.local_shipping, "توصيل", null),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: topCard(
                    context,
                    Icons.bloodtype,
                    "حجز أكياس دم",
                    const BloodTypePage(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff1FA5A9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "من يتبرع لمن؟",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: const [
                  BloodRow("O-", "يتبرع للجميع", "يستقبل من O-"),
                  BloodRow(
                    "O+",
                    "يتبرع لـ O+, A+, B+, AB+",
                    "يستقبل من O+, O-",
                  ),
                  BloodRow(
                    "A-",
                    "يتبرع لـ A-, A+, AB-, AB+",
                    "يستقبل من A-, O-",
                  ),
                  BloodRow("A+", "يتبرع لـ A+, AB+", "يستقبل من A+, A-, O-"),
                  BloodRow(
                    "B-",
                    "يتبرع لـ B-, B+, AB-, AB+",
                    "يستقبل من B-, O-",
                  ),
                  BloodRow("B+", "يتبرع لـ B+, AB+", "يستقبل من B+, B-, O-"),
                  BloodRow("AB-", "يتبرع لـ AB-, AB+", "يستقبل من الجميع"),
                  BloodRow("AB+", "يتبرع لـ AB+ فقط", "المستقبل العام"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topCard(
    BuildContext context,
    IconData icon,
    String title,
    Widget? navigateTo,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: navigateTo == null
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navigateTo),
              );
            },
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff27B4B8), Color(0xff1FA5A9)],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 34),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////

class BloodRow extends StatelessWidget {
  final String type;
  final String donate;
  final String receive;

  const BloodRow(this.type, this.donate, this.receive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xff1FA5A9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donate,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(receive, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
