import 'package:flutter/material.dart';

class PickBloodTypePage extends StatefulWidget {
  const PickBloodTypePage({super.key});

  @override
  State<PickBloodTypePage> createState() => _PickBloodTypePageState();
}

class _PickBloodTypePageState extends State<PickBloodTypePage> {
  static const mainColor = Color(0xFF00A7B3);

  String selectedBlood = '';
  String selectedHospital = 'Hospital';
  int count = 1;

  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  final List<String> hospitals = [
    'Hospital',
    'Hospital A',
    'Hospital B',
    'Hospital C',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ===== Title (سطرين زي الصورة) =====
              const Text(
                'Please pick your\nblood type',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 30),

              // ===== Blood Types =====
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: bloodTypes.map((type) {
                  final isSelected = selectedBlood == type;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBlood = type;
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? mainColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  // Hospital Dropdown
                  Expanded(
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedHospital,
                          items: hospitals.map((h) {
                            return DropdownMenuItem(value: h, child: Text(h));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedHospital = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Counter
                  Container(
                    width: 110,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (count > 1) {
                              setState(() => count--);
                            }
                          },
                          child: const Text(
                            '−',
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                        Text(
                          count.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => count++);
                          },
                          child: const Text(
                            '+',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // ===== Next Button =====
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NextPage()),
                    );
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== Next Page =====
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Next Page', style: TextStyle(fontSize: 24))),
    );
  }
}
